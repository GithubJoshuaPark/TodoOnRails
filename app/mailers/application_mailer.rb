# ApplicationMailer
# 모든 메일러가 상속받는 기본 메일러
# ActionMailer::Base를 상속받아 메일 전송 기능 사용

class ApplicationMailer < ActionMailer::Base
  default from: "from@example.com"
  layout "mailer"
end
