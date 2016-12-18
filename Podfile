# Uncomment this line to define a global platform for your project
# platform :ios, '9.0'

def common_pods
  pod 'AFNetworking'
  pod 'JSONModel'
  pod 'KFSwiftImageLoader', '~> 3.0'
end

target 'Umwerk-Git' do
  # Comment this line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Umwerk-Git
  common_pods
end

target 'Umwerk-Git-Blue' do
  # Comment this line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Umwerk-Git-Blue
  common_pods
end

target 'widget' do
  use_frameworks!

  common_pods
end

target 'widget-blue' do
  use_frameworks!
  
  common_pods
end


post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.0'
    end
  end
end
