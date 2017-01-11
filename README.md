# Pushfile Cloud File Uploader
Upload files to Rackspace Cloud or Amazon S3 by URL or file with automatic image resizing.

### Installation
```
gem install pushfile
```
or add to Gemfile.

### Settings
```ruby
# The settings are stored in ./config/pushfile.yml
@settings = YAML.load_file(File.join(Dir.pwd, 'config', 'pushfile.yml')).deep_symbolize_keys

# The provider, amazon or rackspace
@provider = 'amazon'

# Mode, default is development
@mode = ENV['RACK_ENV'] || 'development'

# Debug
Pushfile.debug = false
```
Create a config/pushfile.yml for your settings.

See [the example pushfile.yml](https://github.com/fugroup/pushfile/blob/master/config/pushfile.yml) for an example.

### Usage
For more examples have a look at [the tests for Pushfile.](https://github.com/fugroup/pushfile/blob/master/test/upload_test.rb)
```ruby
# Require pushfile if not using Bundler
require 'pushfile'

# Create an upload
u = Pushfile::Upload.new

# Actually upload file
u.create

# Get uploaded url with data
u.status # => Hash with urls and data

# Remove file from CDN
u.destroy(url)
```

Created and maintained by [Fugroup Ltd.](https://www.fugroup.net) We are the creators of [CrowdfundHQ.](https://crowdfundhq.com)

`@authors: Vidar`
