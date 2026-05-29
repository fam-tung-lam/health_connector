#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint health_connector_hk_ios.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'health_connector_hk_ios'
  s.version          = '0.0.1'
  s.summary          = 'A new Flutter plugin project.'
  s.description      = <<-DESC
A new Flutter plugin project.
                       DESC
  s.homepage         = 'https://github.com/fam-tung-lam/health_connector/tree/main/packages/health_connector_hk_ios'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Pham Tung Lam' => 'fam.tung.lam@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files = 'health_connector_hk_ios/Sources/health_connector_hk_ios/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '15.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.9'

  # Privacy manifest for HealthKit usage
  s.resource_bundles = {'health_connector_hk_ios_privacy' => ['health_connector_hk_ios/Sources/health_connector_hk_ios/PrivacyInfo.xcprivacy']}
end
