# This file provides setup and common functionality across all features.  It's
# included first before every test run, and the methods provided here can be
# used in any of the step definitions used in a test.  This is a great place to
# put shared data like the location of your app, the capabilities you want to
# test with, and the setup of selenium.

require 'rspec/expectations'
require 'appium_lib'
require 'cucumber/ast'
require_relative 'server.rb'

# Create a custom World class so we don't pollute `Object` with Appium methods
class AppiumWorld
end
server = Server.new
options = {
  'port_a' => 5550,
  'port_b' => 4440,
  'portboot_a' => 5551,
  'portboot_b' => 4441,
  #'sn_a' => '192.168.56.101:5555',
  #'sn_b' => '192.168.56.102:5555'

  'sn_a' => 'LGK3505TZPHE99',
  'sn_b' => '079f93fc00f2d3e8'
}
server.start(options)
# p `nmap -p 5551 localhost`
sleep(10) # TODO replace with serev up validaton
desired_capabilities_a = {
  'deviceName' => options['sn_a'],
  'platformName' => 'Android',
  'appActivity' => '.Main',
  'appPackage' => 'com.skype.raider',
  'noReset' => 'True'
}
desired_capabilities_b = {
  'deviceName' => options['sn_b'],
  'platformName' => 'Android',
  'appActivity' => '.Main',
  'appPackage' => 'com.skype.raider',
  'noReset' => 'True'
}
$driver_a = Appium::Driver.new(caps: desired_capabilities_a, appium_lib: { server_url: "http://localhost:#{options['port_a']}/wd/hub" })
$driver_b = Appium::Driver.new(caps: desired_capabilities_b, appium_lib: { server_url: "http://localhost:#{options['port_b']}/wd/hub" })

World do
  AppiumWorld.new
end

Before do
  $driver_a.start_driver
  $driver_b.start_driver
end
After do
  $driver_a.driver_quit
  $driver_b.driver_quit
end

=begin
# If you wanted one env.rb for both android and iOS, you could use logic similar to this:

world_class = ENV['PLATFORM_NAME'] == 'iOS' ? IosWorld : AndroidWorld

# each world class defines the `caps` method specific to that platform
Appium::Driver.new world_class.caps
Appium.promote_appium_methods world_class
World { world_class.new }

Before { $driver.start_driver }
After { $driver.driver_quit }
=end
