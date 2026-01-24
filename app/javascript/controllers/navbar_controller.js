import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  // 타겟 설정
  static targets = ["menu"]

  // 토글 함수
  toggle() {
    this.menuTarget.classList.toggle("active")
  }

  toggleProfile() {
    const dropdown = document.getElementById("profile-dropdown")
    if (dropdown) {
      dropdown.style.display = dropdown.style.display === "none" ? "flex" : "none"
    }
  }
}
