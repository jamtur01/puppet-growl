require 'puppet'
require 'yaml'

begin
  require 'ruby-growl'
rescue LoadError => e
  Puppet.info "You need the `ruby-growl` gem to use the Growl report"
end

Puppet::Reports.register_report(:growl) do

  configfile = File.join([File.dirname(Puppet.settings[:config]), "growl.yaml"])
  raise(Puppet::ParseError, "Growl report config file #{configfile} not readable") unless File.exist?(configfile)
  config = YAML.load_file(configfile)
  GROWL_SERVER = config[:growl_server]

  desc <<-DESC
  Send notification of failed reports to Growl.
  DESC

  def process
    if self.status == 'failed'
      Puppet.debug "Sending status for #{self.host} to Growl #{GROWL_SERVER}"
      g = Growl.new("#{GROWL_SERVER}", "Puppet", ["Puppet Notification"], ["Puppet Notification"], nil)
      msg = "Puppet run for #{self.host} #{self.status} at #{Time.now.asctime}"
      g.notify("Puppet Notification", "Puppet", msg, 1, true)
    end
  end
end
