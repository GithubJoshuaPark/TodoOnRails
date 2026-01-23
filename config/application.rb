require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TodoOnRails
  class Application < Rails::Application
    # Rails 8.1 버전에 맞는 기본 설정값들을 자동으로 세팅
    config.load_defaults 8.1

    # lib 폴더 안의 파일들도 자동으로 로드되게 할 건지 설정
    config.autoload_lib(ignore: %w[assets tasks])

    # 여기서 타임존이나, 한국어 설정 등을 추가할 수 있습니다.
    config.time_zone = "Seoul"
    config.i18n.default_locale = :ko
  end
end
