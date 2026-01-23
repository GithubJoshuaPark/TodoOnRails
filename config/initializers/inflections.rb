# Be sure to restart your server when you modify this file.

# 역할: Rails가 단수형 <-> 복수형을 변환할 때 사용하는 규칙을 정의합니다.
# Rails는 Person -> People, Mouse -> Mice 같은
# 불규칙 영어 단어도 잘 알지만,
# 만약 Human을 Humen으로 쓰고 싶다거나 할 때
# 여기서 규칙을 추가("irregular")할 수 있습니다.
# SpringBoot 개발자 입장에서는
# "ORM 테이블 이름 매핑 규칙 예외조항"이라고 보시면 됩니다.

# Add new inflection rules using the following format. Inflections
# are locale specific, and you may define rules for as many different
# locales as you wish. All of these examples are active by default:
# ActiveSupport::Inflector.inflections(:en) do |inflect|
#   inflect.plural /^(ox)$/i, "\\1en"
#   inflect.singular /^(ox)en/i, "\\1"
#   inflect.irregular "person", "people"
#   inflect.uncountable %w( fish sheep )
# end

# These inflection rules are supported but not enabled by default:
# ActiveSupport::Inflector.inflections(:en) do |inflect|
#   inflect.acronym "RESTful"
# end
