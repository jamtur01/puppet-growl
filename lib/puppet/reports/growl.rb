require 'puppet'
require 'yaml'

begin
  require 'ruby_gntp'
rescue LoadError => e
  Puppet.info "You need the `ruby_gntp` gem to use the Growl report"
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
    # Make sure that our report handler is registered with Growl
    g = GNTP.new('Puppet Report Notifications', "#{GROWL_SERVER}")
    g.register({
      :notifications => [{
        :name     => 'Failed Puppet Run',
        :enabled  => true,
      },
      {
        :name     => 'Puppet Run',
        :enabled  => true,
      }]
    })
  
    if self.status == 'failed'
      Puppet.debug "Sending failed report for #{self.host} to Growl (#{GROWL_SERVER})"
      msg = "Puppet run for #{self.host} #{self.status} at #{Time.now.asctime}"
      g.notify({
        :name   => "Failed Puppet Run",
        :title  => "Failed Puppet Run",
        :text   => msg,
        :sticky => true
      })
    
    else
      Puppet.debug "Sending successful report for #{self.host} to Growl (#{GROWL_SERVER})"
      msg = "Puppet run for #{self.host} #{self.status} at #{Time.now.asctime}"
      g.notify({
        :name   => "Puppet Run",
        :title  => "Puppet Run",
        :text   => msg,
        :sticky => false
      })
    
    end
  end
end
