# mdbm_dist_support
mdbm distribution support gem

[![Gem Version](https://badge.fury.io/rb/mdbm_dist_support.svg)](https://badge.fury.io/rb/mdbm_dist_support)

## Usage
```
#!/usr/bin/env ruby

require 'mdbm_dist_support'

mds = MdbmDistSupport::Distributer.new do |m|
  m.lock_path         = 'lock file path'
  m.meta_path         = 'local meta mdbm file path'
  m.local_path        = 'local mdbm file path'
  m.dist_path         = 'distribution mdbm file path'
  m.cmd_print         = 'print command ( command to print Key Value seperated TAB to STDOUT )'
  m.cmd_gen           = 'generate mdbm command'
  m.cmd_rep           = 'replace mdbm command'
  m.full_mode         = true
  m.dist_server_hosts = ['distribution target server hosts array']
  m.meta_incr_key     = 'incrementmode key in local meta mdbm'
end

mds.run
```

