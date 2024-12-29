
#
# Be sure to run `pod lib lint CxjToasts.podspec` to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CxjToasts'
  s.version          = '1.0.0'
  s.summary          = 'A flexible library for displaying customizable toasts.'

  s.description = <<-DESC
CxjToasts is a library for iOS that simplifies the creation and management of toast notifications. It includes templated toast designs, supports dynamic layouts, haptics, animations, and allows full customization. The library ensures smooth coexistence and interaction between multiple toasts displayed simultaneously.
  DESC

  s.homepage         = 'https://github.com/coxijcake/CxjToasts'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '<Mikita Biahletski>' => '<mikita.biahletski@gmail.com>' }
  s.source           = { :git => 'https://github.com/coxijcake/CxjToasts.git', :tag => s.version.to_s } 

  s.swift_version = '6.0'
  s.ios.deployment_target = '14.0'

  # Source files path
  s.source_files = 'CxjToasts/Sources/**/*.swift'

  # Framework dependencies
  s.frameworks = ['UIKit']

  # Module name
  s.module_name = 'CxjToasts'
end
