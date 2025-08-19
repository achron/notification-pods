Pod::Spec.new do |s|
  s.name             = 'PSANotificationCenter'
  s.version          = '0.1.0'
  s.summary          = 'Notification center module for PSA'
  s.description      = <<-DESC
                        Core notification center handling for PSA apps.
                       DESC
  s.homepage         = 'https://github.com/achron/notification-pods'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Igor Olnev' => 'igor.olnev@gmail.com' }
  s.source           = { :git => 'https://github.com/achron/notification-pods.git', :branch => 'master' }

  s.ios.deployment_target = '11.0'
  s.source_files     = 'PSANotificationCenter/**/*.{h,m,swift}'
end
