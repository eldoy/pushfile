module Pushfile
  class Upload

    include Pushfile::Data
    include Pushfile::Resize
    include Pushfile::Util
    include Pushfile::Rackspace
    include Pushfile::Amazon

    # Image regexp
    IMAGE_REGEX = /^.+(\.(jpg|jpeg|png|gif|bmp))$/i

    attr_accessor :provider, :file, :timestamp, :name, :thumb, :type, :cdn, :container, :max, :status, :service, :width, :height, :data

    def initialize(o = {})
      # Convert option keys to symbols
      o = o.symbolize_keys

      # Set provider
      @provider = o[:provider] || Pushfile.provider || 'amazon'

      # Extract config
      config = (o.delete(:config).to_sym rescue nil) || :default

      # Default options
      o = {
        :cdn => send("#{@provider}_cdn"),
        :container => send("#{@provider}_container"),
        :max => Pushfile.settings[:upload_limit],
        :snet => Pushfile.mode == 'production',
        :provider => @provider
      }.merge(o)

      # Merge image config
      o = Pushfile.settings[:images][config].merge(o) rescue o

      # Storing options
      @options = o
      @type = o[:type]
      @cdn = o[:cdn]
      @container = o[:container]
      @snet = o[:snet]
      @max = o[:max]
      @width = o[:width]
      @height = o[:height]
      begin
        @service = send(o[:provider])
      rescue
        @status = {:error => 'upload_cant_connect_to_cdn'}
      end
      @data = setup_data
    end

    # Create upload
    def create
      @file = @data.is_a?(String) ? File.open(@data) : @data[:tempfile]

      # Return error if no file
      return (@status = {:error => 'upload_file_not_found'}) unless @file

      @name = filename(@data.is_a?(String) ? @data : @data[:filename])

      # Check if it's more than max or return error
      return (@status = {:error => 'upload_file_size_is_too_big'}) if @max and @file.size > @max

      # Resize file and create thumbnail for image
      if @name =~ IMAGE_REGEX
        resize! if @width or @height
        thumbnail!
      end

      # Store timestamp and type
      @timestamp = @data[:timestamp].nil? ? Time.now.to_i.to_s : @data[:timestamp].to_s
      @type = @data[:type]

      begin
        # Upload file
        @service.directories.new(:key => @container).files.create(
          :content_type => @type,
          :key => (@timestamp ? "#{@timestamp}_#{@name}" : @name),
          :body => @file
        )

        # Upload thumbnail
        if @thumb
          @service.directories.new(:key => @container).files.create(
            :content_type => @type,
            :key => "#{@timestamp}_#{@thumb}",
            :body => File.open("/tmp/#{@thumb}")
          )
          # Delete thumb file
          File.delete("/tmp/#{@thumb}")
        end
      rescue => x
        # Can't connect, report exception.
        @status = {:error => 'upload_cant_connect_to_cdn'}

      else
        thumb_url = @thumb ? "#{@cdn}/#{@timestamp}_#{@thumb}" : nil
        @status = {:url => "#{@cdn}/#{@timestamp}_#{@name}", :thumb_url => thumb_url, :size => @file.size, :mimetype => @type}
        @status
      end
    end

    # Destroy
    def destroy(key)
      begin
        @service.directories.new(:key => @container).files.new(:key => key).destroy
      rescue
        @status = {:error => 'upload_cant_connect_to_cdn'}
      end
    end

  end
end
