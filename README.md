puppet-growl
============

Description
-----------

A Puppet report handler for sending notifications of failed runs to growl.

Requirements
------------

* `ruby-growl`
* `puppet`

Installation & Usage
--------------------

1.  Install the `ruby-growl` gem on your Puppet master

        $ sudo gem install ruby-growl

2.  Install puppet-growl as a module in your Puppet master's module
    path.

3.  Update the `growl_server` variables in the `growl.yaml` file with 
    the IP address of the host to receive the Growl notification and 
    copy the file to `/etc/puppet/`. An example file is included.

4.  On your Growl host enable the "Listen for incoming connections" and 
    "Allow remote application registration" options in your Growl
    configuration.  Ensure UDP port 9887 is open on the host and on any 
    firewalls in between the Puppet master and the host.

5.  Enable pluginsync and reports on your master and clients in `puppet.conf`

        [master]
        report = true
        reports = growl
        pluginsync = true
        [agent]
        report = true
        pluginsync = true

6.  Run the Puppet client and sync the report as a plugin

Author
------

James Turnbull <james@lovedthanlost.net>

License
-------

    Author:: James Turnbull (<james@lovedthanlost.net>)
    Copyright:: Copyright (c) 2011 James Turnbull
    License:: Apache License, Version 2.0

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
