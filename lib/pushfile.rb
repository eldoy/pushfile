require 'active_support'
require 'active_support/core_ext'
require 'fog/rackspace'
require 'fog/aws'
require 'yaml'

# Pushfile Cloud File Upload with Image Resizing
# @homepage: https://github.com/fugroup/pushfile
# @author:   Vidar <vidar@fugroup.net>, Fugroup Ltd.
# @license:  MIT, contributions are welcome.
module Pushfile
  class << self; attr_accessor :settings, :provider, :mode, :debug; end

  # The settings are stored in ./config/pushfile.yml
  @settings = YAML.load_file(File.join(Dir.pwd, 'config', 'pushfile.yml')).deep_symbolize_keys

  # The provider, amazon or rackspace
  @provider = 'amazon'

  # Mode, default is development
  @mode = ENV['RACK_ENV'] || 'development'

  # Debug option
  @debug = false

end

require_relative 'pushfile/data'
require_relative 'pushfile/resize'
require_relative 'pushfile/util'
require_relative 'providers/amazon'
require_relative 'providers/rackspace'
require_relative 'pushfile/upload'

# u = Upload.new(config)
# u.create(data)
# u
