#
# Be sure to run `pod lib lint PineTar.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'PineTar'
  s.version          = '0.2.11'
  s.summary          = 'Helping developers get a grip on Material Design.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'PineTar is a UI, UX iOS library intended to aide developers in visualizing Material Design within Storyboards. It is intended to be a flexible development resource that allows developers to create clean user interfaces without interupted current development patterns.'

  s.homepage         = 'https://github.com/diamondkinetics/PineTar'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'tdmartin4' => 'tomdmartin4@gmail.com' }
  s.source           = { :git => 'https://github.com/diamondkinetics/PineTar.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'

  s.source_files = 'PineTar/Classes/**/*'
  #s.dependency 'SnapKit', '~> 4.0.0'
  s.swift_version = '4.1'
  
  s.resource = ['PineTar/Assets/*']

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
