import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    // Lock body scroll
    document.body.style.overflow = 'hidden'
  }

  disconnect() {
    // Restore body scroll
    document.body.style.overflow = ''
  }

  close(event) {
    if (event) event.preventDefault()

    // Remove the modal element (backdrop and content)
    this.element.remove()

    // Optionally invoke a Turbo visit to reset the URL if needed,
    // but just removing it is fine for ensuring the frame is empty visually.
    const frame = document.getElementById("modal")
    if (frame) {
      frame.src = null
      frame.innerHTML = ""
    }
  }

  closeBackground(event) {
    if (event.target === this.element) {
      this.close(event)
    }
  }
}
