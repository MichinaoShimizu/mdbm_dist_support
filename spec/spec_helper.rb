require "bundler/setup"
require "simplecov"
SimpleCov.start do
  coverage_dir 'coverage'
  add_filter 'spec'
end
require 'mdbm_dist_support'

RSpec.configure do |config|
  config.example_status_persistence_file_path = ".rspec_status"
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
