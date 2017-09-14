#!/usr/bin/env ruby

require 'mdbm_dist_support'

mds = MdbmDistSupport::Distributer.new do |m|
  m.lock_path         = '/home/vc/run/pmbu/tmp/vhl_test.lck'
  m.meta_path         = '/home/vc/run/pmbu/tmp/vhl_test_meta.mdbm'
  m.local_path        = '/home/vc/run/pmbu/tmp/vhl_test.mdbm'
  m.dist_path         = '/home/vc/run/pmbu/tmp/vhl_test_dist.mdbm'
  m.cmd_print         = '/usr/local/vc/new/mdbm_dist_support/print_test.rb'
  m.cmd_gen           = '/home/vc/bin/i64_str_gen'
  m.cmd_rep           = '/usr/local/bin/mdbm_replace'
  m.full_mode         = false
  m.dist_server_hosts = ['localhost']
  m.meta_incr_key     = 'hogehoge_incr_key'
end

mds.run_dist
