import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["container"]

  connect() {
    this.handleResize = this.handleResize.bind(this)
    window.addEventListener('resize', this.handleResize)
    this.checkLayout()
  }

  disconnect() {
    window.removeEventListener('resize', this.handleResize)
  }

  handleResize() {
    this.checkLayout()
  }

  checkLayout() {
    if (window.innerWidth <= 768) {
      this.element.classList.add("mobile-view")
      this.element.classList.remove("desktop-view")
    } else {
      this.element.classList.remove("mobile-view")
      this.element.classList.add("desktop-view")
    }
  }
}
