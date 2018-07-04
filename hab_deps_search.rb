#!/opt/chef/embedded/bin/ruby

# require things
require 'json'
require 'curb'
require 'pp'

# read the command line arg
if ARGV.length < 1
  puts "Usage: hab_dep_search.rb origin/name/version/release"
  exit
else 
  check_dep = ARGV[0]
  puts "Checking for #{check_dep}"
end

puts 

# make the request
# localhost:9631/services
services_json = Curl.get("http://localhost:9631/services")
#puts services_json.body_str

# parse the document
services_hash = JSON.parse(services_json.body_str)
#puts services_hash[0]["service_group"]
#puts services_hash[1]["service_group"]

# We're looking for 
# .[index][pkg][deps][*].[origin|name|version|release] based on
# .[index][pkg][ident]

services_hash.each do | service |
  service["pkg"]["deps"].each do | d |
    dep = "#{d['origin']}/#{d['name']}/#{d['version']}/#{d['release']}"
		if dep.eql? check_dep
			puts "#{service["pkg"]["ident"]} matches"
		end
  end
end


# Report as urls?
# https://bldr.habitat.sh/#/pkgs/$origin/$name/$version/$release
# probably don't care

