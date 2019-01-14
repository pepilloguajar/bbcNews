# Uncomment the next line to define a global platform for your project
platform :ios, '11.0'

def shared_pods
    use_frameworks!
    inhibit_all_warnings!
    pod 'Alamofire', '4.6.0'
    pod 'lottie-ios'
    pod 'XMLParsing', :git => 'https://github.com/ShawnMoore/XMLParsing.git'

end
target 'bbcNewsLOC' do
    workspace 'bbcNews'
    project 'bbcNews'
    shared_pods
end
target 'bbcNews' do
    workspace 'bbcNews'
    project 'bbcNews'
    shared_pods
end
