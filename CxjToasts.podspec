
#
# Be sure to run `pod lib lint CxjToasts.podspec` to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CxjToasts'
  s.version          = '1.0.8'
  s.summary          = 'A flexible library for displaying customizable toasts.'

  s.description = <<-DESC
CxjToasts is a library for iOS that simplifies the creation and management of toast notifications. It includes templated toast designs, supports dynamic layouts, haptics, animations, and allows full customization. The library ensures smooth coexistence and interaction between multiple toasts displayed simultaneously.
  DESC

  s.homepage         = 'https://github.com/coxijcake/CxjToasts'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Mikita Biahletski' => 'mikita.biahletski@gmail.com' }
  s.source           = { :git => 'https://github.com/coxijcake/CxjToasts.git', :tag => s.version.to_s } 

  s.swift_version = '5.9'
  s.ios.deployment_target = '14.0'

  s.source_files = 'Sources/**/*.swift'

  s.resource_bundles = {
  'CxjToastsPrivacyInfo' => ['Sources/PrivacyInfo.xcprivacy'],
  }

  s.module_name = 'CxjToasts'
end
