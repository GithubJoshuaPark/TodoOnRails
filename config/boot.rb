# Gemfile의 위치를 지정
ENV["BUNDLE_GEMFILE"] ||= File.expand_path("../Gemfile", __dir__)

require "bundler/setup" # Set up gems listed in the Gemfile.
require "bootsnap/setup" # Speed up boot time by caching expensive operations.

# Bootsnap이 Bootsnap.setup을 호출하여 Bootsnap을 초기화합니다.
