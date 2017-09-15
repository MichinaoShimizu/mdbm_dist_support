require 'logger'
require 'mdbm_dist_support/version'
require 'mdbm_dist_support/distributer'

module MdbmDistSupport
  $logger = Logger.new(STDERR)
  $logger.level = Logger::INFO
  $logger.datetime_format = '%Y/%m/%d %H:%M:%S'
end
