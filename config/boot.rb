require 'bundler/setup'
Bundler.require(:default, :development)

MODE = ENV['RACK_ENV'] || 'development'

APP_ROOT = Dir.pwd
APP_VIEWS = File.join(APP_ROOT, 'app', 'views')

require './lib/pushfile.rb'
