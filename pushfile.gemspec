Gem::Specification.new do |s|
  s.name        = 'pushfile'
  s.version     = '0.1.0'
  s.date        = '2017-01-22'
  s.summary     = "Pushfile Cloud File Uploader"
  s.description = "Upload files to Rackspace Cloud or Amazon S3 by URL or file with automatic image resizing."
  s.authors     = ["Fugroup Limited"]

  s.add_runtime_dependency 'activesupport', '>= 0'
  s.add_runtime_dependency 'fog-aws', '>= 0'
  s.add_runtime_dependency 'fog-rackspace', '>= 0'
  s.add_runtime_dependency 'mini_magick', '>= 0'

  s.add_development_dependency 'sinatra', '>= 0'
  s.add_development_dependency 'puma', '>= 0'
  s.add_development_dependency 'erubis', '>= 0'
  s.add_development_dependency 'futest', '>= 0'
  s.add_development_dependency 'fuprint', '>= 0'
  s.add_development_dependency 'rack-contrib', '>= 0'

  s.email       = 'mail@fugroup.net'
  s.homepage    = 'https://github.com/fugroup/pushfile'
  s.license     = 'MIT'

  s.require_paths = ['lib']
  s.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features|config)/})
  end
end
