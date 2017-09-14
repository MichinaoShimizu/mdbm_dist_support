# mdbm_dist_support
mdbm distribution support gem

[![Gem Version](https://badge.fury.io/rb/mdbm_dist_support.svg)](https://badge.fury.io/rb/mdbm_dist_support)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## Usage
```
#!/usr/bin/env ruby

require 'mdbm_dist_support'

mds = MdbmDistSupport::Distributer.new do |m|
  m.lock_path         = 'lock file path'
  m.meta_path         = 'local meta mdbm file path'
  m.local_path        = 'local mdbm file path'
  m.dist_path         = 'distribution mdbm file path'
  m.cmd_print         = 'print command path ( command to print Key Value seperated TAB to STDOUT )'
  m.cmd_gen           = 'generate mdbm command path'
  m.cmd_rep           = 'replace mdbm command path'
  m.full_mode         = true/false ( full or increment update )
  m.dist_server_hosts = ['distribution target server hosts array']
  m.meta_incr_key     = 'incrementmode key in local meta mdbm'
end

mds.run
```
|parameter_name|value|
|:-----------|:------------|
|cmd_gen|i64_str_gen / i32_str_gen / i32_i64_gen / i32_i32_gen|

## Requires
* ruby
* ruby-mdbm

## Generate mdbm command module
* int64_str_mdbm
* int32_str_mdbm
* int32_int64_mdbm
* int32_int32_mdbm
