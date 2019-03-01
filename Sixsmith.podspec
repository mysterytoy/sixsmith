Pod::Spec.new do |spec|
  spec.name = 'Sixsmith'
  spec.version = '0.0.2'
  spec.license = 'None'
  spec.homepage = 'https://github.com/lazyaugust/sixsmith'
  spec.authors = { 'Edward Toy' => 'edward.toy@pm.me' }
  spec.summary = 'A swift implementation of Amit Patel\'s hexagon reference.'
  spec.source = { :git => 'https://github.com/lazyaugust/sixsmith.git', :tag => spec.version }
  spec.source_files = 'Sixsmith/**/*.swift'
  spec.ios.deployment_target = '12.0'
  spec.swift_version = '4.0'
end
