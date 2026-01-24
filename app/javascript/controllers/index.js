// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "controllers/application"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"

// 컨트롤러 자동 로드
eagerLoadControllersFrom("controllers", application)
