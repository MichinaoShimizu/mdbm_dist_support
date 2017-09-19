# mdbm_dist_support
mdbm distribution support library gem

[![Gem Version](https://badge.fury.io/rb/mdbm_dist_support.svg)](https://badge.fury.io/rb/mdbm_dist_support)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## Overview
When like below sequence, use this in BAT server.
![overview image](https://github.com/MichinaoShimizu/mdbm_dist_support/blob/master/mdbm_dist.jpg?raw=true)

## Installation
`gem install mdbm-dist-support`

## Usage
This library only provide 2 of method.
* run_dist
* run_print_after  

Use like this.

### Sample
#### update.rb
```ruby
require 'mdbm_dist_support'

MdbmDistSupport::Distributer.new do |m|
  m.lock_path     = '/tmp/hoge.lck'
  m.meta_path     = '/tmp/hoge_meta.mdbm'
  m.local_path    = '/tmp/hoge_local.mdbm'
  m.dist_path     = '/tmp/hoge_dist.mdbm'
  m.cmd_print     = '/tmp/print.rb'
  m.cmd_gen       = :mdbm_store_func
  m.cmd_rep       = '/usr/local/bin/mdbm_replace'
  m.full_mode     = true
  m.dist_servers  =
  [
    'host' => 'remote1', 'port' => 22, 'user' => 'foo', 'key' => '/home/foo/.ssh/id_rsa',
    'host' => 'remote2', 'port' => 22, 'user' => 'hee', 'key' => '/home/hee/.ssh/id_rsa',
    'host' => 'remote3', 'port' => 22, 'user' => 'hyo', 'key' => '/home/hyo/.ssh/id_rsa',
  ]
end.run_dist
```
#### settings @run_dist
|name|value|memo|
|:-----------|:------------|:------------|
|lock_path|lock file path||
|meta_path|meta mdbm path||
|local_path|mdbm path||
|dist_path|mdbm path in remote dist_server_hosts||
|cmd_print|print command path|need to make|
|cmd_gen|generate mdbm command path or `:mdbm_store_func`|need to make if you want to generate mdbm othert than _String:String_ set like _int64:String_, _int32:int64_.if you set `:mdbm_store_func` only, set use mdbm.stroe() function.|
|cmd_rep|replace mdbm command path|[mdbm_replace](https://github.com/yahoo/mdbm/blob/master/gendoc/mdbm_replace.rst)|
|full_mode|`true`: full `false`: inc|when you set `false`, distribute when `meta_mdbm_increment_key` key in meta was updated only.|
|dist_servers|distribute server info array||

#### print.rb
```ruby
require 'mdbm_dist_support'

puts "1111111\tFUGAFUGA"
inc_val = '2017-09-09 11:11:11'

MdbmDistSupport::Distributer.new do |m|
  m.meta_path = '/tmp/hoge_meta.mdbm'
end.run_print_after(inc_val)
```
#### settings @run_print_after
|name|value|
|:-----------|:------------|
|meta_path|meta mdbm path|

## Requires
* [mdbm](https://github.com/yahoo/mdbm)

## Generate mdbm command module

If you want to generate other than `String:String` kvsets, you should make theese commands.

* int64_str_mdbm
* int32_str_mdbm
* int32_int64_mdbm
* int32_int32_mdbm
