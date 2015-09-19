#
# Be sure to run `pod lib lint ShareOne.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "ShareOne"
  s.version          = "0.1.0"
  s.summary          = "A short description of ShareOne."

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!  
  s.description      = <<-DESC
                       DESC

  s.homepage         = "https://github.com/snaill/ShareOne"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "snaill" => "snaill@jeebook.com" }
  s.source           = { :git => "https://github.com/snaill/ShareOne.git", :tag => s.version.to_s }
#  s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

#  s.compiler_flags = '-ENABLE_BITCODE=NO'

  s.source_files = 'Pod/Classes/**/*.{h,m}'
  s.resource_bundles = {
    'ShareOne' => ['Pod/Assets/*.png']
  }

  s.public_header_files = 'Pod/Classes/ShareOne.h'
  # s.frameworks = 'Pod/SDK/TencentOpenAPI-2.9.0-min/TencentOpenAPI.framework'
  # s.dependency 'AFNetworking', '~> 2.3'

  # ――― Subspec ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.subspec 'TencentOpenAPI' do |ts|
    ts.resources = "Pod/SDK/TencentOpenAPI-2.9.0-min/TencentOpenApi_IOS_Bundle.bundle"
    ts.vendored_frameworks = "Pod/SDK/TencentOpenAPI-2.9.0-min/TencentOpenAPI.framework"
    ts.frameworks = 'Security','CoreTelephony','SystemConfiguration','CoreGraphics'
    ts.libraries  = 'z','sqlite3','iconv','stdc++'
  end

  s.subspec 'Weixin' do |ts|
    ts.vendored_libraries = "Pod/SDK/WeChatSDK_1.5/libWeChatSDK.a"
    ts.source_files = "Pod/SDK/WeChatSDK_1.5/**/*.h"
  end

  s.default_subspecs = 'TencentOpenAPI', 'Weixin'

end
