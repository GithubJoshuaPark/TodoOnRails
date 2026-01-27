import { Controller } from "@hotwired/stimulus"

// Rich Editor Controller using Quill
export default class extends Controller {
  static targets = ["editor", "hiddenField", "toolbar"]

  connect() {
    // Load Quill if not already loaded
    this.loadQuill().then(() => {
      this.initializeEditor()
    })
  }

  async loadQuill() {
    // Check if Quill is already loaded
    if (window.Quill) {
      return Promise.resolve()
    }

    // Load Quill CSS
    const cssLink = document.createElement('link')
    cssLink.rel = 'stylesheet'
    cssLink.href = 'https://cdn.quilljs.com/1.3.6/quill.snow.css'
    document.head.appendChild(cssLink)

    // Load Quill JS
    return new Promise((resolve, reject) => {
      const script = document.createElement('script')
      script.src = 'https://cdn.quilljs.com/1.3.6/quill.js'
      script.onload = resolve
      script.onerror = reject
      document.head.appendChild(script)
    })
  }

  initializeEditor() {
    const readonly = this.editorTarget.dataset.readonly === 'true'
    const placeholder = this.editorTarget.dataset.placeholder || 'Start typing...'

    // Initialize Quill
    const toolbarOptions = readonly ? false : [
      ['bold', 'italic', 'underline'],
      [{ 'list': 'ordered'}, { 'list': 'bullet' }],
      ['link']
    ]

    this.quill = new Quill(this.editorTarget, {
      theme: 'snow',
      readOnly: readonly,
      placeholder: placeholder,
      modules: {
        toolbar: toolbarOptions
      }
    })

    // Sync content to hidden field on change
    this.quill.on('text-change', () => {
      const html = this.editorTarget.querySelector('.ql-editor').innerHTML
      this.hiddenFieldTarget.value = html
    })

    // Set initial content
    const initialContent = this.hiddenFieldTarget.value
    if (initialContent) {
      this.quill.clipboard.dangerouslyPasteHTML(initialContent)
    }

    // Style the editor for dark theme
    this.styleEditor()
  }

  styleEditor() {
    const qlEditor = this.editorTarget.querySelector('.ql-editor')
    if (qlEditor) {
      qlEditor.style.color = 'white'
      qlEditor.style.minHeight = '120px'
    }

    const qlToolbar = this.editorTarget.querySelector('.ql-toolbar')
    if (qlToolbar) {
      // If readonly, hide the toolbar completely
      if (this.editorTarget.dataset.readonly === 'true') {
        qlToolbar.style.display = 'none'
        qlToolbar.style.border = 'none'
      } else {
        qlToolbar.style.background = 'rgba(255, 255, 255, 0.05)'
        qlToolbar.style.border = '1px solid rgba(255, 255, 255, 0.1)'
        qlToolbar.style.borderRadius = '10px 10px 0 0'
      }
    } else {
      // If no toolbar (quill 1.3.6 might still create a container or borders), ensure no top border on editor
      if (qlEditor) {
        qlEditor.style.borderTop = 'none'
      }
    }
  }

  disconnect() {
    if (this.quill) {
      this.quill = null
    }
  }
}
