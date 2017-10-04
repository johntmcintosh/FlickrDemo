source 'https://github.com/CocoaPods/Specs.git'


platform :ios, '11.0'

target 'FlickrDemo' do
    
    pod 'AlamofireImage', '3.3.0'
    pod 'Result', '3.2.4'
    pod 'SwiftyJSON', '3.1.4'
    
    target 'FlickrDemoTests' do
        inherit! :search_paths
        
        # This is a pod I'm developing on top of FBSnapshotTestCase that's not quite ready for public release yet.
        pod 'SnapshotKit', :git => 'git@github.com:johntmcintosh/SnapshotKit.git', :branch => 'master'
    end
end


use_frameworks!
inhibit_all_warnings!
