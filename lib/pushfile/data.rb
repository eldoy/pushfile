module Pushfile
  module Data

    # Setup methods.
    # Currently ajax uploads, froala uploads and url uploads are supported.

    # Set up data
    def setup_data
      # Fetch the image into a tempfile, and store
      if @options[:url]
        url_upload

      elsif @options[:filename]
        ajax_upload

      # Do the froala file uploads
      elsif @options[:file]
        froala_upload

      end
    end

    # Ajax upload
    def ajax_upload
      filename = @options[:filename]
      type = @options[:mimetype] || mimetype(filename)
      file = @options[:tempfile] || "/tmp/upload-#{filename}"

      # Pass stream (typically request.body) to read chunks
      if @options[:stream]
        File.open(file, 'w') do |f|
          f.binmode
          while buffer = @options[:stream].read(51200)
            f << buffer
          end
        end
      end

      {:filename => filename, :tempfile => File.new(file), :type => type}
    end

    # Froala upload
    def froala_upload
      tmpfile = @options[:file][:tempfile]
      filename = @options[:file][:filename]
      type = @options[:file][:type] || mimetype(filename)

      {:filename => filename, :tempfile => tmpfile, :type => type}
    end

    # URL upload
    def url_upload
      url = @options[:url].strip

      file = Tempfile.new('tmp').tap do |file|
        file.binmode # must be in binary mode
        file.write RestClient.get(url)
        file.rewind
      end

      # Extract the file name from the URL
      filename = url.split('/').last

      # Mime type
      type = @options[:mimetype] || mimetype(filename)

      {:filename => filename, :type => type, :tempfile => file}
    end

    private

    # Get the mime type from a file name
    def mimetype(path)
      extension = File.basename(path).split('.')[-1]
      Rack::Mime.mime_type(".#{extension}")
    end

  end
end
