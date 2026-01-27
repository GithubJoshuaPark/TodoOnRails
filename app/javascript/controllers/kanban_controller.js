import { Controller } from "@hotwired/stimulus"
import Sortable from "sortablejs"

// Connects to data-controller="kanban"
export default class extends Controller {
  static targets = ["column"]

  connect() {
    this.sortables = []
    this.handleResize = this.handleResize.bind(this)
    window.addEventListener('resize', this.handleResize)

    const isMobile = window.innerWidth <= 768

    this.columnTargets.forEach(column => {
      const sortable = new Sortable(column.querySelector(".kanban-cards"), {
        group: 'todos', // Share dragging between lists
        draggable: ".kanban-card",
        animation: 150,
        ghostClass: 'sortable-ghost',
        disabled: isMobile, // Disable on mobile initially
        onEnd: this.updateStatus.bind(this)
      })
      this.sortables.push(sortable)
    })
    this.checkEmptyStates()
  }

  disconnect() {
    window.removeEventListener('resize', this.handleResize)
  }

  handleResize() {
    const isMobile = window.innerWidth <= 768
    this.sortables.forEach(sortable => {
      sortable.option('disabled', isMobile)
    })
  }

  updateStatus(event) {
    const item = event.item
    const newStatus = event.to.closest(".kanban-column").dataset.status
    const todoId = item.dataset.todoId

    // 1. Check if status actually changed
    if (event.from === event.to) return

    // 2. Send PATCH request to server
    const url = `/todos/${todoId}`
    const csrfToken = document.querySelector("meta[name='csrf-token']").content

    fetch(url, {
      method: "PATCH",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": csrfToken,
        "Accept": "application/json"
      },
      body: JSON.stringify({
        todo: {
          status: newStatus
        }
      })
    }).then(response => {
      if (response.ok) {
        // Success: Maybe show a toast notification?
        // Updating empty state visual if needed
        this.checkEmptyStates()
      } else {
        // Error: Revert the move
        event.from.appendChild(item)
        alert("Failed to update status. Please try again.")
      }
    }).catch(error => {
      console.error("Error:", error)
      event.from.appendChild(item)
    })
  }

  checkEmptyStates() {
    this.columnTargets.forEach(column => {
      // .kanban-card 클래스를 가진 요소만 카운트 (Sortable의 draggable 옵션과 일치)
      const cardCount = column.querySelectorAll(".kanban-card").length
      const emptyState = column.querySelector(".kanban-empty")

      if (emptyState) {
        if (cardCount === 0) {
          emptyState.style.display = "block"
        } else {
          emptyState.style.display = "none"
        }
      }
    })
  }
}
