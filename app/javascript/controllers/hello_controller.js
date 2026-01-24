import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  // 컨트롤러가 DOM에 연결되었을 때 실행
  connect() {
    this.element.textContent = "Hello World!"
  }
}
