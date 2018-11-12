#!/usr/bin/env ruby

# require things
require 'json'
require 'curb'
require 'pp'

# Look for command line arg
if ARGV.length < 1
  host = "localhost"
else
  host = ARGV[0]
end

# make the request
# localhost:9631/services
services_json = Curl.get("http://#{host}:9631/services")
#puts services_json.body_str

# parse the document
services_hash = JSON.parse(services_json.body_str)
#puts services_hash[0]["service_group"]
#puts services_hash[1]["service_group"]

# We're looking for 
# .[index][pkg][deps][*].[origin|name|version|release] based on
# .[index][pkg][ident]

services_hash.each do | service |
  puts service["pkg"]["ident"]
  service["pkg"]["deps"].each do | d |
    dep = "|-  #{d['origin']}/#{d['name']}/#{d['version']}/#{d['release']}"
    puts dep
  end
  puts
end


# Report as urls?
# https://bldr.habitat.sh/#/pkgs/$origin/$name/$version/$release
# probably don't care

