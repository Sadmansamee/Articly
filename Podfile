# Uncomment the next line to define a global platform for your project
platform :ios, '10.0'

target 'NyBestArticles' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  
  # Pods for NyBestArticles
  
  pod 'Moya', '~> 13.0'
  pod 'Kingfisher', '~> 5.0'
  pod 'RxSwift', '~> 5'
  pod 'RxCocoa', '~> 5'
  pod 'Swinject' , '~> 2.7.1'
  pod 'SwinjectStoryboard', :git => "https://github.com/Swinject/SwinjectStoryboard" , :branch => 'master'
  pod 'RealmSwift'
  pod 'ReachabilitySwift'

  target 'NyBestArticlesTests' do
    inherit! :search_paths
  use_frameworks!
	
    # Pods for testing
    pod 'SpecLeaks'
    pod 'RxBlocking', '~> 5'
    pod 'Quick'
    pod 'Nimble'
    pod 'Swinject' , '~> 2.7.1'
    pod 'SwinjectStoryboard', :git => "https://github.com/Swinject/SwinjectStoryboard" , :branch => 'master'
    
    post_install do |installer|
      installer.pods_project.targets.each do |target|
        if ['SpecLeaks'].include? target.name
            target.build_configurations.each do |config|
                config.build_settings['ENABLE_BITCODE'] = 'NO'
            end
        end
      end
    end
    
  end
  
  
end
