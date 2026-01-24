import { Application } from "@hotwired/stimulus"

// Stimulus 애플리케이션 시작
const application = Application.start()

// Stimulus 개발 경험 설정
application.debug = false
window.Stimulus   = application

// 애플리케이션 내보내기
export { application }
