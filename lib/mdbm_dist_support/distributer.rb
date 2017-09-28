require 'mdbm_dist_support/custom_logger'
require 'mdbm_dist_support/meta'
require 'mdbm_dist_support/lock'
require 'mdbm_dist_support/validator'
require 'tempfile'
require 'shellwords'
require 'mdbm'

module MdbmDistSupport
  # Mdbm distributer
  class Distributer
    INCR_KEY = 'meta_mdbm_increment_key'.freeze
    attr_accessor :lock_path, :meta_path, :meta, :local_path,\
                  :dist_path, :cmd_print, :cmd_gen, :cmd_rep,\
                  :dist_servers, :full_mode

    include MdbmDistSupport::CustomLogger

    def initialize
      yield self if block_given?
      @meta = MdbmDistSupport::Meta.new(@meta_path)
    end

    def run_dist
      unless MdbmDistSupport::Validator.valid_run_dist_settings?(instance_variables)
				raise InvalidSettingsError
			end
      unless MdbmDistSupport::Lock.new(@lock_path).try_lock
				raise MissLockError
			end
      dist if local_up
      @@logger.info "#{__method__} complete"
    end

    def run_print_after(meta_val)
      unless MdbmDistSupport::Validator.valid_run_print_after_settings?(instance_variables)
				raise InvalidSettingsError
			end
      @meta.store(INCR_KEY, meta_val)
    end

    private

    def local_up
      rc = true
      Tempfile.create('mdbm_dist_support') do |f|
        date_b = @meta.fetch(INCR_KEY)
        cmd_exec %(#{@cmd_print} > #{f.path})
        date_a = @meta.fetch(INCR_KEY)

        if @full_mode == false && date_a == date_b
          rc = false
          @@logger.info 'no need to update'
        else
          (@cmd_gen == :mdbm_store_func) ? do_mdbm_store(f) : do_outer_gen_cmd(f)
        end
      end
      rc
    rescue => e
      @@logger.error e
      return false
    end

    def do_mdbm_store(f)
      f.each_line do |s|
        kv = s.chomp.split("\t")
        m = Mdbm.new(@local_path, Mdbm::MDBM_O_RDWR | Mdbm::MDBM_O_CREAT, 0644, 0, 0)
        m.store(kv[0], kv[1], Mdbm::MDBM_REPLACE)
      end
    end

    def do_outer_gen_cmd(f)
      cmd_exec %(cat #{se(f.path)} | #{se(@cmd_gen)} #{se(@local_path)})
    end

    def dist
      @dist_servers.each do |s|
        cmd_exec %(scp -P #{se(s['port'])} -i #{se(s['key'])} #{se(@local_path)} #{se(s['user'])}@#{se(s['host'])}:#{se(@dist_path)}.tmp)
        cmd_exec %(ssh -p #{se(s['port'])} -i #{se(s['key'])} #{se(s['user'])}@#{se(s['host'])} \" #{se(@cmd_rep)} #{se(@dist_path)} #{se(@dist_path)}.tmp && chmod 777 #{se(@dist_path)}\")
      end
    end

    def se(str)
      Shellwords.escape(str)
    end

    def cmd_exec(cmd)
      @@logger.info cmd
      Kernel.system cmd
      unless $?.exitstatus.zero?
				raise MissExecSubprocessError
			end
    end
  end
end
