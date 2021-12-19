Pod::Spec.new do |spec|
  spec.name             = 'UHIHTTPClient'
  spec.version          = '0.6.0'
  spec.license          = { :type => 'MIT', :file => 'LICENSE' }
  spec.summary          = 'Communicate via HTTP easily in Swift.'
  spec.homepage         = 'https://github.com/uhooi/swift-http-client'
  spec.author           = { 'uhooi' => 'the_uhooi@yahoo.co.jp' }
  spec.social_media_url = 'https://twitter.com/the_uhooi'
  spec.source           = { :git => 'https://github.com/uhooi/swift-http-client.git', :tag => spec.version.to_s }
  spec.source_files     = 'Sources/**/*.swift'
  spec.swift_versions   = ['5.5.2']
  spec.framework        = 'Foundation'

  spec.ios.deployment_target     = '13.0'
  spec.osx.deployment_target     = '10.15'
  spec.tvos.deployment_target    = '13.0'
  spec.watchos.deployment_target = '6.0'
end
