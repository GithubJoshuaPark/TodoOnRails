import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toast"
export default class extends Controller {
  connect() {
    // Auto-dismiss after 5 seconds (5000ms)
    setTimeout(() => {
      this.close()
    }, 5000)
  }

  close() {
    // Add a fade-out class for animation
    this.element.classList.add("fade-out")

    // Wait for animation to finish before removing element
    this.element.addEventListener("animationend", () => {
      this.element.remove()
    })
  }
}
