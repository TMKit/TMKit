#
# Be sure to run `pod lib lint TMKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'TMKit'
  s.version          = '0.2.0'
  s.summary          = 'This library supports Objc&Swift and has a number of tools and methods for iOS development'

  s.description      = <<-DESC
  This library supports Objc&Swift and has a number of tools and methods for iOS development
                       DESC

  s.homepage         = 'https://github.com/TMKit/TMKit'
  s.screenshots     = 'https://avatars1.githubusercontent.com/u/28727841?v=3&s=600'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Teemo' => 'cjianneng@outlook.com' }
  s.source           = { :git => 'https://github.com/TMKit/TMKit.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'
  s.source_files = 'Classes/**/*'
  s.frameworks = 'UIKit'


end
