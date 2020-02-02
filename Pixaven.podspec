Pod::Spec.new do |spec|
  spec.name          = "Pixaven"
  spec.version       = "1.0.3"
  spec.summary       = "The official Swift integration for the Pixaven Image API"
  spec.description   = "Pixaven is an enterprise-grade image processing SaaS. Resize, scale, crop, mask, filter and enhance your images with blazing speed."
  spec.homepage      = "https://github.com/pixaven/pixaven-swift"
  spec.license       = { :type => 'MIT', :file => 'LICENSE' }
  spec.author        = { "Pixaven" => "support@pixaven.com" }
  spec.source        = { :git => "https://github.com/pixaven/pixaven-swift.git", :tag => "#{spec.version}" }
  spec.source_files   = 'Pixaven/Classes/**/*'
  spec.ios.deployment_target = "13.0"
  spec.osx.deployment_target  = "10.14"
  spec.frameworks     = 'UIKit', 'Foundation', 'MobileCoreServices'
  spec.swift_version  = '5.0'
end