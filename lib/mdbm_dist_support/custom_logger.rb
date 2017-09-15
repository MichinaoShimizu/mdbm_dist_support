require 'logger'

module MdbmDistSupport
  # logger
  module CustomLogger
    @@logger = Logger.new(STDERR)
    @@logger.level = Logger::INFO
    @@logger.datetime_format = '%Y/%m/%d %H:%M:%S'
  end
end
