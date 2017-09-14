module MdbmDistSupport
  # Lockfile manager
  class Lock
    attr_accessor :lock_file, :lock_status

    def initialize(path)
      @lock_file = open(path, 'w')
    end

    def try_lock
      @lock_file.flock(File::LOCK_EX | File::LOCK_NB)
    end
  end
end
