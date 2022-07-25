source 'https://cdn.cocoapods.org/'
platform :ios, '13.0'
inhibit_all_warnings!
install! 'cocoapods',
  :warn_for_unused_master_specs_repo => false
  
def rx_swift
    pod 'RxSwift'
end

def test_pods
    pod 'RxTest'
    pod 'RxBlocking'
end


target 'Project' do
  use_frameworks!
  rx_swift
  pod 'RxCocoa'
  pod 'SnapKit'
  pod 'Toast-Swift'
  pod 'SwiftFormat/CLI', '~> 0.49'
  pod 'SwiftLint', '~> 0.47'
  pod 'AlamofireImage'
  target 'ProjectTests' do
    inherit! :search_paths
    test_pods
  end

end

target 'Domain' do
  use_frameworks!
  rx_swift

  target 'DomainTests' do
    inherit! :search_paths
    test_pods
  end

end

target 'NetworkPlatform' do
    use_frameworks!
    rx_swift
    pod 'Alamofire'
    pod 'RxAlamofire'

    target 'NetworkPlatformTests' do
        inherit! :search_paths
        test_pods
    end
    
end

target 'RealmPlatform' do
  use_frameworks!
  rx_swift
  pod 'RxRealm'
  pod 'RealmSwift'
  pod 'Realm'

  target 'RealmPlatformTests' do
    inherit! :search_paths
    test_pods
  end

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
    end
  end
end
