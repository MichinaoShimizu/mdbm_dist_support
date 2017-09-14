module MdbmDistSupport
  # settings input validator
  class Validator
    REQUIRE_INSTANCE_VARS =
      [:@lock_path, :@meta_path, :@local_path, :@dist_path, :@cmd_print,\
       :@cmd_gen, :@cmd_rep, :@full_mode, :@dist_server_hosts,\
       :@meta_incr_key].freeze

    class << self
      def check(settings)
        df = REQUIRE_INSTANCE_VARS - settings
        unless df.length.zero?
          raise %(#{df.to_s} : Required settings is undefined. )
        end
      end
    end
  end
end
