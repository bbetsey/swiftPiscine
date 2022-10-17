#
# Be sure to run `pod lib lint bbetsey2022.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'bbetsey2022'
  s.version          = '0.1.0'
  s.summary          = 'Ecole42 Project'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: My First CocoaPods Library (bbetsey, august, 2022).
                       DESC

  s.homepage         = 'https://github.com/70851552/bbetsey2022'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '70851552' => 'bbetsey12@gmail.com' }
  s.source           = { :git => 'https://github.com/70851552/bbetsey2022.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'

  s.source_files = 'bbetsey2022/Classes/**/*.swift'
	s.resource = 'bbetsey2022/*.xcdatamodeld'
  
	# s.resource_bundles = {
	#   'bbetsey2022' => ['bbetsey2022/Assets/*.png']
	# }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit', 'CoreData'
  # s.dependency 'AFNetworking', '~> 2.3'
end
