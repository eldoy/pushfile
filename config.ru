Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8

# Init the app
require './config/boot.rb'
require './app.rb'

# Set up middleware stack
app = Rack::Builder.new do
  use Fuprint::Request
  use Rack::PostBodyContentTypeParser
  run App
end

run app
