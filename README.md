# Pushfile Cloud File Uploader
Upload files to Rackspace Cloud or Amazon S3 by URL or file with automatic image resizing.

### Installation
```
gem install pushfile
```
or add to Gemfile.

### Settings
```ruby
# Debug
Pushfile.debug = false
```
Create a config/pushfile.yml for your settings.

See [the example pushfile.yml](https://github.com/fugroup/pushfile/blob/master/config/pushfile.yml) for an example.

### Usage
For a real-world example with a test runner ready, have a look at [the tests for Pushfile.](https://github.com/fugroup/pushfile/tree/master/test)
```ruby
# Require pushfile if not using Bundler
require 'pushfile'

# Create an upload
u = Pushfile::Upload.new
u.status # => Hash with urls and data
```

Created and maintained by [Fugroup Ltd.](https://www.fugroup.net) We are the creators of [CrowdfundHQ.](https://crowdfundhq.com)

`@authors: Vidar`
