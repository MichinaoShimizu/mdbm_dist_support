# mdbm_dist_support
mdbm distribution support library gem

[![Gem Version](https://badge.fury.io/rb/mdbm_dist_support.svg)](https://badge.fury.io/rb/mdbm_dist_support)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## Installation
`gem install mdbm-dist-support`

## Usage
This library only provide 2 of method.
* run_dist
* run_print_after  

Use like this.

### Sample
#### update.rb
```
#!/usr/bin/env ruby

require 'mdbm_dist_support'

MdbmDistSupport::Distributer.new do |m|
  m.lock_path         = '/tmp/hoge.lck'
  m.meta_path         = '/tmp/hoge_meta.mdbm'
  m.local_path        = '/tmp/hoge_local.mdbm'
  m.dist_path         = '/tmp/hoge_dist.mdbm'
  m.cmd_print         = '/tmp/print.rb'
  m.cmd_gen           = '/usr/local/bin/i64_str_gen'
  m.cmd_rep           = '/usr/local/bin/mdbm_replace'
  m.full_mode         = true
  m.dist_server_hosts = ['localhost']
  m.meta_incr_key     = 'when_processed_fetched_max_date'
end.run_dist
```
#### required settings @run_dist
|name|value|memo|
|:-----------|:------------|:------------|
|lock_path|local lock file path||
|meta_path|local meta mdbm path||
|local_path|local mdbm path||
|dist_path|mdbm path in remote servers||
|cmd_print|print command path|you need to make this command|
|cmd_gen|generate mdbm command path|you need to make this command|
|cmd_rep|replace mdbm command path|[mdbm_replace](https://github.com/yahoo/mdbm/blob/master/gendoc/mdbm_replace.rst)|
|full_mode|_true_: always update / _false_: when meta_incr_key is changed, do dist||
|dist_server_hosts|distribute target server hosts array||
|meta_incr_key|meta mdbm key(using increment update)||

#### print.rb
```
#!/usr/bin/env ruby

require 'mdbm_dist_support'

# fetch data and print STDOUT KEY:VALUE set
puts "1111111\tFUGAFUGA"

# fetch db max-date or max id
fetched_max_date = '2017-09-09 11:11:11'

# print after, update meta increment val.
MdbmDistSupport::Distributer.new do |m|
  m.meta_path = 'local meta mdbm file path'
  m.meta_incr_key = 'when_processed_fetched_max_date'
end.run_print_after(fetched_max_date)
```
#### required settings @run_print_after
|name|value|memo|
|:-----------|:------------|:------------|
|meta_path|local meta mdbm path||
|meta_incr_key|meta mdbm key (using increment update)||

## Requires
* [mdbm](https://github.com/yahoo/mdbm)
* ruby
* ruby-mdbm

## Generate mdbm command module
* int64_str_mdbm
* int32_str_mdbm
* int32_int64_mdbm
* int32_int32_mdbm
