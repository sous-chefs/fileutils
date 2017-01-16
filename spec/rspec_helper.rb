# Cookbook Name:: fileutils
# spec:: rspec_helper
#
# Copyright 2017, Nordstrom Inc.
#

require_relative '../libraries/change_help'
require_relative '../libraries/delete_help'
RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
end
