require 'mdbm_dist_support/custom_logger'

module MdbmDistSupport
  # Lockfile manager
  class Lock
    attr_accessor :lock_file

    include MdbmDistSupport::CustomLogger

    def initialize(path)
      @lock_file = open(path, 'w')
    end

    def try_lock
      @lock_file.flock(File::LOCK_EX | File::LOCK_NB) || raise
      true
    rescue
      @@logger.error "cannot get lock. #{@lock_file.path}"
      false
    end
  end
end
