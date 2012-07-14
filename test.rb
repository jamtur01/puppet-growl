require 'rubygems'
require 'ruby_gntp'

# -- Standard way
growl = GNTP.new("Ruby/GNTP self test", '192.168.2.1')
growl.register({:notifications => [{
  :name     => "notify",
  :enabled  => true,
}]})

growl.notify({
  :name  => "notify",
  :title => "Congratulations",
  :text  => "Congratulations! You have successfully installed ruby_gntp.",
  :sticky=> true,
})