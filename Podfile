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

target 'MatchPoint' do
  sharedPods

  target 'MatchPointTests' do
      inherit! :search_paths
      pod 'Nimble-Snapshots'
      pod 'Quick'
  end

  target 'MatchPointUITests' do
      inherit! :search_paths
  end
end

target 'MatchPointWidget' do
    sharedPods
end

target 'MatchPoint WatchOS Extension' do
    platform :watchos, '4.0'
    pod 'Moya'
    pod 'SwiftyAttributes'
    pod 'SwiftWatchConnectivity'
end
