#!/usr/bin/env ruby

# require things
require 'json'
require 'curb'
require 'pp'
require 'optparse'

# read the command line args
options = {}

parser = OptionParser.new do |opts|
  opts.banner = "Usage: hab_service_versions [options]"
  
  options[:host] = "localhost"
  opts.on('-h', '--host HOST', String, 'Hostname or IP to test') do |your_host|
    options[:host] = your_host
  end
  
  options[:check_sg] = nil
  opts.on('-g', '--group SERVICE_GROUP', String, 'Service group to check versions for') do |your_sg|
    options[:check_sg] = your_sg
  end

  opts.on('--help', 'Displays help') do
    puts opts
    exit
  end
end

parser.parse!
begin
  raise OptionParser::MissingArgument if options[:check_sg].nil?
rescue OptionParser::MissingArgument
  puts $!.to_s
  puts parser
  exit
end


puts "searching host #{options[:host]} for dep #{options[:check_sg]}" 

# make the request
# localhost:9631/butterfly
services_json = Curl.get("http://#{options[:host]}:9631/butterfly")

# parse the document
services_hash = JSON.parse(services_json.body_str)

# We're looking for 
# [service][list][check_sg][package]

services_hash["service"]["list"][options[:check_sg]].each do | service, values|
  puts "#{values["sys"]["ip"]} has version #{values["package"]}"
end

