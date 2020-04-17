
platform :ios, '13.0'

def test_pods
  pod 'Quick'
  pod 'Nimble'
  pod 'RxSwift', '~> 5.1'
end

target 'GitRepos' do
  use_frameworks!

  pod 'Alamofire', '~> 5.1'
  pod 'AlamofireImage', '~> 4.1'
  pod 'RxCocoa', '~> 5.1'
  pod 'RxSwift', '~> 5.1'

  target "GitReposTests" do
    inherit! :search_paths
    test_pods
    pod 'OHHTTPStubs/Swift'
  end

  target "GitReposUITests" do
    inherit! :search_paths
    test_pods
    pod 'iOSSnapshotTestCase'
    pod 'Nimble-Snapshots'
  end
end
