# Be sure to restart your server when you modify this file.

# Define an application-wide content security policy.
# See the Securing Rails Applications Guide for more information:
# https://guides.rubyonrails.org/security.html#content-security-policy-header
#
# (보안 🛡️)역할: 웹 사이트의 보안 정책(CSP) 을 설정합니다.
# 핵심: "우리 사이트에서는 네이버 스크립트는 실행해도 되지만,
# 해커가 심어놓은 스크립트는 실행 안 돼!" 처럼 허용된 출처(Source) 만
# 실행하도록 브라우저에게 지시합니다. (XSS 공격 방어)
# 현재는 주석 처리되어 있어 기본값이 사용됩니다.

# Rails.application.configure do
#   config.content_security_policy do |policy|
#     policy.default_src :self, :https
#     policy.font_src    :self, :https, :data
#     policy.img_src     :self, :https, :data
#     policy.object_src  :none
#     policy.script_src  :self, :https
#     policy.style_src   :self, :https
#     # Specify URI for violation reports
#     # policy.report_uri "/csp-violation-report-endpoint"
#   end
#
#   # Generate session nonces for permitted importmap, inline scripts, and inline styles.
#   config.content_security_policy_nonce_generator = ->(request) { request.session.id.to_s }
#   config.content_security_policy_nonce_directives = %w(script-src style-src)
#
#   # Automatically add `nonce` to `javascript_tag`, `javascript_include_tag`, and `stylesheet_link_tag`
#   # if the corresponding directives are specified in `content_security_policy_nonce_directives`.
#   # config.content_security_policy_nonce_auto = true
#
#   # Report violations without enforcing the policy.
#   # config.content_security_policy_report_only = true
# end
