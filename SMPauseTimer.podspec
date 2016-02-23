#
# Be sure to run `pod lib lint SMPauseTimer.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "SMPauseTimer"
  s.version          = "0.2.1"
  s.summary          = "Provides the ability to pause an NSTimer."
 
  s.description      = <<-DESC
Provides the ability to pause an NSTimer & resume at a later time of your choosing. Will also pause & resume when the app changes states.
                       DESC

  s.homepage         = "https://github.com/seanmcneil/SMPauseTimer"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Sean McNeil" => "mcneilsean@icloud.com" }
  s.source           = { :git => "https://github.com/seanmcneil/SMPauseTimer.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/sean_mcneil'

  s.platform     = :ios, '8.1'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'SMPauseTimer' => ['Pod/Assets/*.png']
  }

end
