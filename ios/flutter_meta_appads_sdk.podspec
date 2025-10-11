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
  s.source_files = 'flutter_meta_appads_sdk/Sources/flutter_meta_appads_sdk/**/*.{h,m,swift}'
  s.resource_bundles = {'flutter_meta_appads_sdk_privacy' => ['flutter_meta_appads_sdk/Sources/flutter_meta_appads_sdk/PrivacyInfo.xcprivacy']}


  s.dependency 'Flutter'
  s.dependency 'FBSDKCoreKit', '~> 18.0.1'

  s.platform = :ios, '13.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
