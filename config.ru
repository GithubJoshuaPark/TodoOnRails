# This file is used by Rack-based servers to start the application.
# Rack 기반 웹 서버(예: Puma, Unicorn, Passenger)가 애플리케이션을 시작할 때 사용하는 진입점(Entry Point)
require_relative "config/environment"

run Rails.application
Rails.application.load_server
