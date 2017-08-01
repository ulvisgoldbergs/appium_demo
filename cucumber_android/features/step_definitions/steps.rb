# These are the 'step definitions' which Cucumber uses to implement features.
#
# Each step starts with a regular expression matching the step you write in
# your feature description.  Any variables are parsed out and passed to the
# step block.
#
# The instructions in the step are then executed with those variables.
#
# In this example, we're using rspec's assertions to test that things are happening,
# but you can use any ruby code you want in the steps.
#
# The '$driver' object is the appium_lib driver, set up in the cucumber/support/env.rb
# file, which is a convenient place to put it as we're likely to use it often.
# This is a different use to most of the examples;  Cucumber steps are instances
# of `Object`, and extending Object with Appium methods (through
# `promote_appium_methods`) is a bad idea.
#
# For more on step definitions, check out the documentation at
# https://github.com/cucumber/cucumber/wiki/Step-Definitions
#
# For more on rspec assertions, check out
# https://www.relishapp.com/rspec/rspec-expectations/docs

Given /^I click about phone$/ do
  $driver_a.scroll_to('About phone').click
  $driver_b.scroll_to('About phone').click
end

Given /^the Android version is a number$/ do
  android_version = 'Android version'
  $driver_a.scroll_to android_version
  $driver_b.scroll_to android_version
  view    = 'android.widget.TextView'
  version = $driver_a.xpath(%Q(//#{view}[preceding-sibling::#{view}[@text="#{android_version}"]])).text
  valid   = !version.match(/\d/).nil?

  expect(valid).to eq(true)
end

Given /^I open compad$/ do
 $driver_a.find_element(:xpath, "//android.widget.TextView[contains(@text, 'SkypeDemo')]").click
 $driver_b.find_element(:xpath, "//android.widget.TextView[contains(@text, 'SkypeDemo')]").click
 sleep(2)
end

Given /^I am chatting and make calls$/ do
  element_a = $driver_a.find_element(:xpath, "//android.widget.EditText")
  element_b = $driver_b.find_element(:xpath, "//android.widget.EditText")
  while(true)
	begin
		element_a.send_keys("Hello!")
    $driver_a.find_element(:xpath, "//android.widget.Button[contains(@content-desc, 'Send message')]").click

		element_b.send_keys("Hi!!")
    $driver_b.find_element(:xpath, "//android.widget.Button[contains(@content-desc, 'Send message')]").click

    element_a.send_keys("Are you busy right now?")
    $driver_a.find_element(:xpath, "//android.widget.Button[contains(@content-desc, 'Send message')]").click

    element_b.send_keys("No, I am free at the moment")
    $driver_b.find_element(:xpath, "//android.widget.Button[contains(@content-desc, 'Send message')]").click

    element_a.send_keys("Can I call you?")
    $driver_a.find_element(:xpath, "//android.widget.Button[contains(@content-desc, 'Send message')]").click

    element_b.send_keys("Sure!")
    $driver_b.find_element(:xpath, "//android.widget.Button[contains(@content-desc, 'Send message')]").click

    # $driver_a.find_element(:xpath, "//android.widget.Button[contains(@content-desc, 'Audio Call')]").click
    # $driver_b.find_element(:xpath, "//android.widget.Button[contains(@content-desc, 'with voice only')]").click
		# $driver_a.find_element(:xpath, "//android.widget.Button[contains(@content-desc, 'End call')]").click

		element_a.send_keys("Thanks for the conversation!")
		$driver_a.find_element(:xpath, "//android.widget.Button[contains(@content-desc, 'Send message')]").click

		element_b.send_keys("No problem!")
		$driver_b.find_element(:xpath, "//android.widget.Button[contains(@content-desc, 'Send message')]").click

		element_a.send_keys("See you later!")
		$driver_a.find_element(:xpath, "//android.widget.Button[contains(@content-desc, 'Send message')]").click

		element_b.send_keys("Ok, bye!")
		$driver_b.find_element(:xpath, "//android.widget.Button[contains(@content-desc, 'Send message')]").click
	rescue Exception => message
    p message
	end
  end
end
