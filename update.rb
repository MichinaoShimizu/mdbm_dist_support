#!/usr/bin/env ruby
require 'mdbm_dist_support'

MdbmDistSupport::Distributer.new do |m|
  m.lock_path      = '/tmp/hoge.lck'
  m.meta_path      = '/tmp/hoge_meta.mdbm'
  m.local_path     = '/tmp/hoge_local.mdbm'
  m.dist_path      = '/tmp/hoge_dist.mdbm'
  m.cmd_print      = '/tmp/print.rb'
  m.cmd_gen        = :mdbm_store_func
  m.cmd_rep        = '/usr/local/bin/mdbm_replace'
  m.full_mode      = true
  m.dist_servers   = [ :host => 'localhost', :port => 61204, :user => 'shimizu', :key => '/home/shimizu/.ssh/id_rsa.bk']
end.run_dist
