#!/opt/chef/embedded/bin/ruby

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
services_json = Curl.get("http://#{host}:9631/butterfly")
#puts services_json.body_str

# parse the document
services_hash = JSON.parse(services_json.body_str)
#puts services_hash
#puts services_hash.keys

# We're looking for 
# [member][members][X][address] 
members_hash = services_hash.slice("member")

puts "My partners are:"

members_hash["member"]["members"].each do | member, v |
  puts v["address"]
end


