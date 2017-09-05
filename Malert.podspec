#
# Be sure to run `pod lib lint Malert.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Malert'
s.version          = '1.2'
  s.summary          = 'A simple, easy and very customizable alert'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
    Malert came to facilitate make custom alert views, introducing as `UIAlertViewController`. Malert allows you make some custom configurations to show your alert as your application layout. Malert can display one or a queue of alerts and you can to display alert with some animations.
                       DESC

  s.homepage         = 'https://github.com/vitormesquita/Malert'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Vitor Mesquita' => 'vitor.mesquita09@jera.com.br' }
  s.source           = { :git => 'https://github.com/vitormesquita/Malert.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'Malert/Classes/**/*'
  s.resource_bundles = {
    'Malert' => ['Malert/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'

s.dependency 'Cartography', '~> 1.1'
end
