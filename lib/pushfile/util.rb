module Pushfile
  module Util

    # Make sure the file name is valid
    def filename(name)
      # Replace space with underscore and downcase extension
      pre, dot, ext = name.rpartition('.')
      name = "#{pre.gsub(' ', '_')}.#{ext.downcase}"

      # Remove illegal characters
      # http://stackoverflow.com/questions/13517100/whats-the-difference-between-palpha-i-and-pl-i-in-ruby
      name = name.gsub(%r{[^\p{L}\-\_\.0-9]}, '')

      name
    end


  end
end
