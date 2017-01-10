module Pushfile
  module Rackspace

    # Set up rackspace
    def rackspace
      Fog::Storage.new(
        :provider => 'Rackspace',
        :rackspace_username => Pushfile.settings[:rackspace_username],
        :rackspace_api_key => Pushfile.settings[:rackspace_key],
        # Defaults to :dfw
        :rackspace_region => :ord,
        # :connection_options  => {}
        :rackspace_servicenet => @snet
      )
    end

    # Rackspace cdn
    def rackspace_cdn
      Pushfile.settings[:rackspace_cdn]
    end

    # Rackspace container
    def rackspace_container
      Pushfile.settings[:rackspace_container]
    end

  end
end
