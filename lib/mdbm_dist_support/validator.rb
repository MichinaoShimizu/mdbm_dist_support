module MdbmDistSupport
  # settings input validator
  class Validator
    RUN_DIST_REQUIRE_INSTANCE_VARS =
      [:@lock_path, :@meta_path, :@local_path, :@dist_path, :@cmd_print,\
       :@cmd_gen, :@cmd_rep, :@full_mode, :@dist_server_hosts,\
       :@meta_incr_key].freeze

    RUN_PRINT_AFTER_REQUIRE_INSTANCE_VARS = [:@meta_path, :@meta_incr_key].freeze

    class << self
      def check_run_dist(settings)
        df = RUN_DIST_REQUIRE_INSTANCE_VARS - settings
        unless df.length.zero?
          raise %(#{df.to_s} : Required settings is undefined. )
        end
      end

      def check_run_print_after(settings)
        df = RUN_PRINT_AFTER_REQUIRE_INSTANCE_VARS - settings
        unless df.length.zero?
          raise %(#{df.to_s} : Required settings is undefined.)
        end
      end
    end
  end
end
