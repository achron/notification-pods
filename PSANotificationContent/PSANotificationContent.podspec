Pod::Spec.new do |s|
  s.name             = 'PSANotificationContent'
  s.version          = '0.1.0'
  s.summary          = 'Notification content extension for PSA'
  s.description      = <<-DESC
                        Handles rich push notification content (images, actions, etc).
                       DESC
  s.homepage         = 'https://github.com/achron/notification-pods'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Igor Olnev' => 'igor.olnev@gmail.com' }
  s.source           = { :git => 'https://github.com/achron/notification-pods.git', :branch => 'master' }

  s.ios.deployment_target = '11.0'
  s.source_files     = 'PSANotificationContent/**/*.{h,m,swift}'
end
