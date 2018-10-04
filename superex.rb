#!/opt/chef/embedded/bin/ruby

require 'habitat_supervisor'
require 'pp'

client = HabitatSupervisor::Client.new()
client.service('container_sched_backend.default')

pp client

