module MdbmDistSupport
  # settings input validator
  class Validator
    RUN_DIST_REQUIRE_INSTANCE_VARS =
      %i[@lock_path @meta_path @local_path @dist_path @cmd_print
         @cmd_gen @cmd_rep @full_mode @dist_server_hosts
         @meta_incr_key].freeze

    RUN_PRINT_AFTER_REQUIRE_INSTANCE_VARS =
      %i[@meta_path @meta_incr_key].freeze

    class << self
      def valid_run_dist_settings?(settings)
        rc = true
        df = RUN_DIST_REQUIRE_INSTANCE_VARS - settings
        unless df.length.zero?
          $logger.error %(#{df} is required )
          rc = false
        end
        rc
      end

      def valid_run_print_after_settings?(settings)
        rc = true
        df = RUN_PRINT_AFTER_REQUIRE_INSTANCE_VARS - settings
        unless df.length.zero?
          $logger.error %(#{df} is required)
          rc = false
        end
        rc
      end
    end
  end
end
