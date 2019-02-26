# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'TalentTestLogin' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
pod 'FacebookCore'
pod 'FacebookLogin'
pod 'FacebookShare'
#pod 'MobileVLCKit', '3.2.1'
pod 'Firebase/Auth'
pod 'Firebase/Core'
pod 'Firebase/Messaging'
pod 'GoogleSignIn'
pod 'SCLAlertView'
pod 'NVActivityIndicatorView'
pod 'Alamofire'
pod 'SVGKit'
pod 'JSONWebToken'

  # Pods for TalentTestLogin

  target 'TalentTestLoginTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'TalentTestLoginUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end

post_install do |installer|
    
    installer.pods_project.targets.each do |target|
        
        if target.name == 'JSONWebToken'
            system("rm -rf Pods/JSONWebToken/CommonCrypto")
        end
        
    end
    
end
