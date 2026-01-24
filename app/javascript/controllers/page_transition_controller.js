import { Controller } from "@hotwired/stimulus"

// Page Transition Controller
// Adds smooth fade effects during Turbo page transitions
export default class extends Controller {
  connect() {
    // Already faded in via CSS, just ensure it's visible
    document.body.style.opacity = "1"
  }

  // This runs before navigating away
  beforeVisit(event) {
    // Quick fade out
    document.body.style.transition = "opacity 0.15s ease-out"
    document.body.style.opacity = "0"
  }

  // This runs when the new page is about to render
  beforeRender(event) {
    // Prepare for fade in
    document.body.style.opacity = "0"
  }

  // This runs after the new page has rendered
  render(event) {
    // Restore and trigger fade in animation
    setTimeout(() => {
      document.body.style.transition = "opacity 0.3s ease-in"
      document.body.style.opacity = "1"
    }, 10)
  }
}
