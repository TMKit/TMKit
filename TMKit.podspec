#
# Be sure to run `pod lib lint TMKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'TMKit'
  s.version          = '0.2.2'
  s.summary          = '  This library supports Objc&Swift, TMKit has many tools and methods for iOS development'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  This library supports Objc&Swift, TMKit has many tools and methods for iOS development
                       DESC

  s.homepage         = 'https://github.com/TMKit/TMKit'
  s.screenshots     = 'https://avatars1.githubusercontent.com/u/28727841?v=3&s=600'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Teemo' => 'cjianneng@outlook.com' }
  s.source           = { :git => 'https://github.com/TMKit/TMKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'
  s.source_files = 'Classes/**/*'
# s.public_header_files = ["Classes/**/TMKit.h"]
  s.frameworks = 'UIKit'

  # s.resource_bundles = {
  #   'TMKit' => ['TMKit/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'

  # s.dependency 'AFNetworking', '~> 2.3'
end
