require "watir-webdriver"
#$openemr="http://opensourceemr.com:2089/openemr"
def startBrowser()
#profile = Selenium::WebDriver::Chrome::Profile.new
#profile.add_extension "/Users/yehster/AppData/Roaming/Mozilla/Firefox/Profiles/91entnug.default/extensions/firebug@software.joehewitt.com.xpi"
b = Watir::Browser.new :firefox, :profile => 'watir'
return b
end