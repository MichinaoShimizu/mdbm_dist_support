# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mdbm_dist_support/version'

Gem::Specification.new do |spec|
  spec.name          = 'mdbm_dist_support'
  spec.version       = MdbmDistSupport::VERSION
  spec.authors       = ['MichinaoShimizu']
  spec.email         = ['shimizu.michinao@gmail.com']
  spec.summary       = %(mdbm distribution support gem)
  spec.description   = %(mdbm distribution support gem)
  spec.homepage      = 'https://github.com/MichinaoShimizu/mdbm_dist_support'
  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.require_paths = ['lib']
  spec.add_development_dependency 'bundler', '~> 1.14'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_runtime_dependency     'ruby-mdbm', '>= 0.0.2'
end
