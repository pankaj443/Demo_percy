require 'rubygems'
require 'selenium-webdriver'
# Input capabilities
caps = Selenium::WebDriver::Remote::Capabilities.new
caps['browser'] = 'Chrome'
caps['os_version'] = '10'
caps['resolution'] = '1920x1080'
caps['os'] = 'Windows'
caps['browser_version'] = 'latest'
caps['javascriptEnabled'] = 'true'
caps['name'] = 'BStack-[Ruby] Sample Test' # test name
caps['build'] = 'BStack Build Number 1' # CI/CD job or build name
driver = Selenium::WebDriver.for(:remote,
  :url => "https://pankajyadav21:6gkDLBEZLxqhwUofRnvB@hub-cloud.browserstack.com/wd/hub",
  :desired_capabilities => caps)
# Searching for 'BrowserStack' on google.com
driver.navigate.to "http://www.google.com"
element = driver.find_element(:name, "q")
element.send_keys "BrowserStack"
element.submit
puts driver.title
# Setting the status of test as 'passed' or 'failed' based on the condition; if title of the web page starts with 'BrowserStack'
if driver.title[0,12]=="BrowserStack"
  driver.execute_script('browserstack_executor: {"action": "setSessionStatus", "arguments": {"status":"passed", "reason": "Yaay! Title matched!"}}')
else
  driver.execute_script('browserstack_executor: {"action": "setSessionStatus", "arguments": {"status":"failed", "reason": "Oops! Title did not match"}}')
end
driver.quit 