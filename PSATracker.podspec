Pod::Spec.new do |s|
  s.name             = 'PSATracker'
  s.version          = '0.1.0'
  s.summary          = 'PSATracker module'
  s.description      = <<-DESC
                        Core tracker module for PSA Notifications.
                       DESC
  s.homepage         = 'https://github.com/achron/notification-pods'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Igor Olnev' => 'igor.olnev@gmail.com' }
  s.source           = { :git => 'https://github.com/achron/notification-pods.git', :branch => 'master' }

  s.ios.deployment_target = '11.0'
  s.source_files     = 'PSATracker/**/*.{h,m,swift}'

  s.dependency 'PSANotificationContent'
  s.dependency 'PSANotificationCenter'
end