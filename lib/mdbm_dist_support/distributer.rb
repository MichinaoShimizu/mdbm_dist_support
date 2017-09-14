require 'mdbm_dist_support/meta'
require 'mdbm_dist_support/lock'
require 'mdbm_dist_support/validator'
require 'tempfile'

module MdbmDistSupport
  # Mdbm distributer
  class Distributer
    attr_accessor :lock_path, :lock, :meta_path, :meta, :local_path,\
                  :dist_path, :cmd_print, :cmd_gen, :cmd_rep,\
                  :dist_server_hosts, :meta_incr_key, :full_mode

    def initialize
      yield self if block_given?
    end

    def run
      MdbmDistSupport::Validator::check(instance_variables)
      @lock = MdbmDistSupport::Lock.new(@lock_path)
      @meta = MdbmDistSupport::Meta.new(@meta_path)
      @lock.try_lock
      local_up
    end

    private

    def local_up
      date_b = @meta.fetch(@meta_incr_key)
      Tempfile.create('mdbmdistributesupport') do |f|
        Kernel.system %(#{@cmd_print} #{date_b} > #{f.path})
        date_a = @meta.fetch(@meta_incr_key)
        break if @full_mode == false && date_a <= date_b
        Kernel.system %(cat #{f.path} | #{@cmd_gen} #{@local_path})
        @meta.store(@meta_incr_key, date_a)
        dist
      end
    end

    def dist
      @dist_server_hosts.each do |s|
        Kernel.exec %(scp -o StrictHostKeychecking=no #{@local_path} #{s}:#{@dist_path}.tmp)
        Kernel.exec %(ssh -o StrictHostKeychecking=no #{s} \" #{@cmd_rep} #{@dist_path} #{@dist_path}.tmp && chmod 777 #{@dist_path}\")
      end
    end
  end
end
