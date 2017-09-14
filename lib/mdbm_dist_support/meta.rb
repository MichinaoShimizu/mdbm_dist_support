require 'mdbm'

module MdbmDistSupport
  # Meta mdbm manager
  class Meta
    attr_accessor :meta

    def initialize(path)
      @meta ||= Mdbm.new(path, Mdbm::MDBM_O_RDWR | Mdbm::MDBM_O_CREAT, 0644, 0, 0)
    end

    def fetch(key)
      @meta.fetch(key) || self.store(key, 0)
    end

    def store(key, val)
      @meta.store(key.to_s, val.to_s, Mdbm::MDBM_REPLACE)
    end
  end
end
