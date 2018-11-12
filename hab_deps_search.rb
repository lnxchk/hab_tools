#!/usr/bin/env ruby

# require things
require 'json'
require 'curb'
require 'pp'
require 'optparse'

# read the command line args
options = {}

parser = OptionParser.new do |opts|
  opts.banner = "Usage: hab_deps_search [options]"
  
  options[:host] = "localhost"
  opts.on('-h', '--host HOST', String, 'Hostname or IP to test') do |your_host|
    options[:host] = your_host
  end
  
  options[:check_dep] = nil
  opts.on('-d', '--dep DEPENDENCY', String, 'Dependency to check for') do |your_dep|
    options[:check_dep] = your_dep
  end

  opts.on('--help', 'Displays help') do
    puts opts
    exit
  end
end

parser.parse!
begin
  raise OptionParser::MissingArgument if options[:check_dep].nil?
rescue OptionParser::MissingArgument
  puts $!.to_s
  puts parser
  exit
end


puts "searching host #{options[:host]} for dep #{options[:check_dep]}" 

# make the request
# localhost:9631/services
services_json = Curl.get("http://#{options[:host]}:9631/services")

# parse the document
services_hash = JSON.parse(services_json.body_str)

# We're looking for 
# .[index][pkg][deps][*].[origin|name|version|release] based on
# .[index][pkg][ident]

services_hash.each do | service |
  service["pkg"]["deps"].each do | d |
    dep = "#{d['origin']}/#{d['name']}/#{d['version']}/#{d['release']}"
		if dep.eql? options[:check_dep]
			puts "#{service["pkg"]["ident"]} matches"
		end
  end
end

