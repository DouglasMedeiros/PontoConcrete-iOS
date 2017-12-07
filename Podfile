platform :ios, '10.0'
inhibit_all_warnings!
use_frameworks!

def sharedPods
  pod 'SnapKit'
  pod 'Moya'
  pod 'KeychainSwift'
  pod 'JVFloatLabeledTextField'
  pod 'SwiftLint'
  pod 'SwiftyAttributes'
  pod 'FontAwesome.swift'
  pod 'SwiftWatchConnectivity'
end

target 'PontoConcrete' do
  sharedPods

  target 'PontoConcreteTests' do
      inherit! :search_paths
      pod 'Nimble-Snapshots'
      pod 'Quick'
  end

  target 'PontoConcreteUITests' do
      inherit! :search_paths
  end
  target 'PontoConcreteWidget' do
      inherit! :search_paths
      sharedPods
  end
end

target 'PontoConcrete WatchOS Extension' do
    platform :watchos, '4.0'
    pod 'Moya'
    pod 'SwiftyAttributes'
    pod 'SwiftWatchConnectivity'
end
