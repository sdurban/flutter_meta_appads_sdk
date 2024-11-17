#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint flutter_meta_appads_sdk.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'flutter_meta_appads_sdk'
  s.version          = '0.0.1'
  s.summary          = 'Meta SDK for Flutter. This package allow you to integration with Facebook SDK using developer facebook dashboard, track flutter app events.'
  s.description      = <<-DESC
Meta SDK for Flutter. This package allow you to integration with Facebook SDK using developer facebook dashboard, track flutter app events.
                       DESC
  s.homepage         = 'https://sergio.durban.cat'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Sergio Durban Belmonte' => 'sergio@durban.cat' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.dependency 'FBSDKCoreKit', '~> 17.4.0'
  s.dependency 'SwiftProtobuf', '~> 1.0'

  s.platform = :ios, '12.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'

  # If your plugin requires a privacy manifest, for example if it uses any
  # required reason APIs, update the PrivacyInfo.xcprivacy file to describe your
  # plugin's privacy impact, and then uncomment this line. For more information,
  # see https://developer.apple.com/documentation/bundleresources/privacy_manifest_files
  # s.resource_bundles = {'flutter_meta_appads_sdk_privacy' => ['Resources/PrivacyInfo.xcprivacy']}
end