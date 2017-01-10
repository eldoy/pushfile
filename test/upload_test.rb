test 'Upload'

f = File.new('./test/fugroup_avatar.jpg')
is f.size, :gt => 0

is Pushfile.mode, 'development'
is Pushfile.provider, 'amazon'


base = File.basename(f.path)
tmp = "/tmp/upload-#{base}"

stop "#{tmp} doesn't exist" unless File.file?(tmp)

test '* config'
options = {'filename' => File.basename(f.path), :tempfile => tmp, 'mimetype' => 'image/jpeg'}

u = Pushfile::Upload.new(options.merge(:config => :campaign))
is u.width, 610

u = Pushfile::Upload.new(options.merge(:config => :asdf))
is u.width, nil

u = Pushfile::Upload.new(options.merge(:config => :default))
is u.width, 590

u = Pushfile::Upload.new(options)
is u.width, 590

u = Pushfile::Upload.new
is u.width, 590


test '* ajax upload, amazon'

options = {'filename' => File.basename(f.path), :tempfile => tmp, 'mimetype' => 'image/jpeg'}

u = Pushfile::Upload.new(options)

is u.provider, 'amazon'
is u.container, '7ino'
is u.width, 590
is u.status, nil

u.create
is u.status, :a? => Hash
is u.status[:url], :a? => String
is u.status[:mimetype], 'image/jpeg'


test '* ajax upload, rackspace'

Pushfile.provider = 'rackspace'

u = Pushfile::Upload.new(options)

is u.provider, 'rackspace'
is u.container, 'crowdfundhq'
is u.status, nil

u.create
is u.status, :a? => Hash
is u.status[:url], :a? => String
is u.status[:mimetype], 'image/jpeg'


test '* max size'

Pushfile.provider = 'amazon'

options = {:max => 1, 'filename' => File.basename(f.path), :tempfile => tmp, 'mimetype' => 'image/jpeg'}

u = Pushfile::Upload.new(options)

is u.max, 1
u.create

is u.status, :a? => Hash
is u.status[:error], 'upload_file_size_is_too_big'

# Ajax upload
# {"filename"=>"morning-tur-nyttnorge.jpg", "mimetype"=>"image/jpeg", "size"=>"61606", "preventCache"=>"8P6qZe2G9ij6VmSzKsDR47ArMczrjZ", "config"=>"files"}

# Froala upload
# {"config"=>"campaign", "file"=>{:filename=>"fugroup_avatar.jpeg", :type=>"image/jpeg", :name=>"file", :tempfile=>#<Tempfile:/var/folders/t4/b0c2hjbx55z074nqmg74s_ch0000gn/T/RackMultipart20170110-87813-909yn0.jpeg>, :head=>"Content-Disposition: form-data; name=\"file\"; filename=\"fugroup_avatar.jpeg\"\r\nContent-Type: image/jpeg\r\n"}}
