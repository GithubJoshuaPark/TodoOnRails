// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

Turbo.config.forms.confirm = (message, element) => {
  const dialog = document.getElementById("confirm-modal")
  const title = document.getElementById("confirm-modal-title")
  const msg = document.getElementById("confirm-modal-message")
  const cancelBtn = document.getElementById("confirm-modal-cancel")
  const proceedBtn = document.getElementById("confirm-modal-proceed")

  // 다이얼로그가 없으면 기본 confirm 사용
  if (!dialog) {
    return Promise.resolve(confirm(message))
  }

  // 메시지 설정
  msg.textContent = message
  // 다이얼로그 표시
  dialog.showModal()

  // Promise 반환
  return new Promise((resolve, reject) => {
    // 다이얼로그 닫기
    const closeDialog = () => {
      dialog.close()
    }

    // 취소 버튼 처리
    const handleCancel = () => {
      resolve(false)
      closeDialog()
      cleanup()
    }

    // 진행 버튼 처리
    const handleProceed = () => {
      resolve(true)
      closeDialog()
      cleanup()
    }

    // 이벤트 리스너 정리
    const cleanup = () => {
      cancelBtn.removeEventListener("click", handleCancel)
      proceedBtn.removeEventListener("click", handleProceed)
      dialog.removeEventListener("close", handleCancel) // Handle Escape key
    }

    // 이벤트 리스너 추가
    cancelBtn.addEventListener("click", handleCancel)
    proceedBtn.addEventListener("click", handleProceed)
    dialog.addEventListener("close", handleCancel)
  })
}
