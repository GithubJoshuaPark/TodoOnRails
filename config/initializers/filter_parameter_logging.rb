# Be sure to restart your server when you modify this file.

# Configure parameters to be partially matched (e.g. passw matches password)
# and filtered from the log file.
#
# (보안 🛡️) 역할: 서버 로그에 찍히면 안 되는 민감한 정보를 가려줍니다.
# 예: 로그인할 때 password를 입력하면,
# 로그에는 password: [FILTERED] 라고 나옵니다.
# :passw, :token, :card 같은 단어가 포함된 파라미터는 자동으로 가려집니다.
#
# Use this to limit dissemination of sensitive information.
# See the ActiveSupport::ParameterFilter documentation for supported notations and behaviors.
Rails.application.config.filter_parameters += [
  :passw, :email, :secret, :token, :_key, :crypt, :salt, :certificate, :otp, :ssn, :cvv, :cvc
]
