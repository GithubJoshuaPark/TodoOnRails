// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

Turbo.config.forms.confirm = (message, element) => {
  const dialog = document.getElementById("confirm-modal")
  const title = document.getElementById("confirm-modal-title")
  const msg = document.getElementById("confirm-modal-message")
  const cancelBtn = document.getElementById("confirm-modal-cancel")
  const proceedBtn = document.getElementById("confirm-modal-proceed")

  if (!dialog) {
    return Promise.resolve(confirm(message))
  }

  msg.textContent = message
  dialog.showModal()

  return new Promise((resolve, reject) => {
    const closeDialog = () => {
      dialog.close()
    }

    const handleCancel = () => {
      resolve(false)
      closeDialog()
      cleanup()
    }

    const handleProceed = () => {
      resolve(true)
      closeDialog()
      cleanup()
    }

    const cleanup = () => {
      cancelBtn.removeEventListener("click", handleCancel)
      proceedBtn.removeEventListener("click", handleProceed)
      dialog.removeEventListener("close", handleCancel) // Handle Escape key
    }

    cancelBtn.addEventListener("click", handleCancel)
    proceedBtn.addEventListener("click", handleProceed)
    dialog.addEventListener("close", handleCancel)
  })
}
