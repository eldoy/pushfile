# Pushfile Cloud File Uploader
Upload files to Rackspace Cloud or Amazon S3 by URL or file, with automatic image resizing and thumbnails.

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

If you define an image config, any images you upload will be automatically resized before uploading. You can define both the desired max height and width. All images will also be thumbnailed.

### Usage
For more examples have a look at [the tests for Pushfile.](https://github.com/fugroup/pushfile/blob/master/test/upload_test.rb)
```ruby
# Require pushfile if not using Bundler
require 'pushfile'

# Set up a new upload from web server params
# The Froala editor support is automatic
u = Pushfile::Upload.new(params)

# Ajax upload with progress support, pass the request body StringIO object
u = Pushfile::Upload.new(params.merge(:stream => request.body))

# Set up a new upload from local file
u = Pushfile::Upload.new(:filename => 'name.jpg', :tempfile => '/tmp/name.jpg')

# Upload from remote URL
u = Pushfile::Upload.new(:url => 'http://fugroup.net/images/fugroup_logo1.png')

# Actually upload file to CDN
u.create

# Get uploaded url with data
u.status # => Hash with urls and data

# Example response hash
{
  # The file URL
  :url => "http://f.7i.no/1484109810_fugroup_avatar.jpg",

  # The thumbnail URL (only for images)
  :thumb_url => "http://f.7i.no/1484109810_fugroup_avatar_thumb.jpg",

  # The size of the file after resizing
  :size => 40288,

  # The file's mime type
  :mimetype => "image/jpeg"
}

# Remove file from CDN
u.destroy(url)
```

Created and maintained by [Fugroup Ltd.](https://www.fugroup.net) We are the creators of [CrowdfundHQ.](https://crowdfundhq.com)

`@authors: Vidar`
