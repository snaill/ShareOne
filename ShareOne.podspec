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
  s.summary          = "微信QQ分享库"

  s.homepage         = "https://github.com/snaill/ShareOne"
  s.license          = 'MIT'
  s.author           = { "snaill" => "snaill@jeebook.com" }
  s.source           = { :git => "https://github.com/snaill/ShareOne.git", :tag => s.version.to_s }
#  s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  # ――― Platform ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.platform     = :ios, '8.0'

  # ――― Build settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.requires_arc = true

  s.pod_target_xcconfig = { 'ENABLE_BITCODE' => 'NO' }

  s.source_files = 'Pod/Classes/**/*.{h,m}', 'Pod/SDK/WeChatSDK_1.5/**/*.h'
  s.resource = 'Pod/Assets/*.png'

  s.public_header_files = 'Pod/Classes/ShareOne.h'

  s.vendored_frameworks = "Pod/SDK/TencentOpenAPI-2.9.0-min/TencentOpenAPI.framework"
  s.vendored_libraries = "Pod/SDK/WeChatSDK_1.5/libWeChatSDK.a"
  s.frameworks = 'Security','CoreTelephony','SystemConfiguration','CoreGraphics'
  s.libraries  = 'z','sqlite3','iconv','stdc++'

  # ――― Subspec ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

end
