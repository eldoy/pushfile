module Pushfile
  module Amazon

    # Set up amazon
    def amazon
      Fog::Storage.new(
        :provider => 'AWS',
        :aws_access_key_id => Pushfile.settings[:amazon_key],
        :aws_secret_access_key => Pushfile.settings[:amazon_secret]
      )
    end

    # Amazon cdn
    def amazon_cdn
      "#{Pushfile.settings[:amazon_cdn]}/#{Pushfile.settings[:amazon_container]}"
    end

    # Amazon container
    def amazon_container
      Pushfile.settings[:amazon_container]
    end
  end
end
