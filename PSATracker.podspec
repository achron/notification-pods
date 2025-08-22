Pod::Spec.new do |s|
  s.name             = 'PSATracker'
  s.version          = '1.0.0'
  s.summary          = 'Tracker module with Notification components'
  s.homepage         = 'https://github.com/achron/notification-pods'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'achron' => 'you@example.com' }
  s.source           = { :git => 'https://github.com/achron/notification-pods.git', :branch => 'master' }

  s.ios.deployment_target = '12.0'
  s.requires_arc = true

  s.dependency 'FMDB'
  s.dependency 'Firebase/Core'
  s.dependency 'Firebase/Auth'     # If you need authentication
  s.dependency 'Firebase/Database' # If you need Realtime Database
  s.dependency 'Firebase/Firestore


  # основной модуль
  s.subspec 'Core' do |ss|
    ss.source_files = 'PSATracker/**/*.{h,m,swift}'
  end

  # контент-экстеншн
  s.subspec 'NotificationContent' do |ss|
    ss.source_files = 'PSANotificationContent/**/*.{h,m,swift}'
  end

  # сервис-экстеншн
  s.subspec 'NotificationService' do |ss|
    ss.source_files = 'PSANotificationService/**/*.{h,m,swift}'
  end
end
