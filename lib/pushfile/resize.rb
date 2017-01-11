module Pushfile
  module Resize

    autoload :MiniMagick, 'mini_magick'

    # Resize file. Keeping aspect ratio.
    def resize!
      begin
        image = MiniMagick::Image.open(@file.path)
        image.resize("#{@width}x#{@height}")
      rescue
        # Pass on any error
      else
        image.write(@file.path) rescue nil
      end
    end

    # Create thumbnail, same name but with _thumb at the end
    def thumbnail!
      begin
        image = MiniMagick::Image.open(@file.path)
        image.resize("#{Pushfile.settings[:images][:thumb][:width]}x")
      rescue
        @thumb = nil
      else
        t = @name.split('.')
        ext = t.pop
        @thumb = t.join(".").concat("_thumb.#{ext}")

        image.write("/tmp/#{@thumb}") rescue @thumb = nil
      end
    end

  end
end
