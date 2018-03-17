#
# Cookbook:: fileutils
# Resource:: default
#
# Copyright 2017, Nordstrom, Inc.
# Licensed under the Apache License, Version 2.0 (the "License")
#

default_action :create
property :path, String, name_property: true
property :pattern, Regexp
property :recursive, [TrueClass, FalseClass], default: true
property :follow_symlink, [TrueClass, FalseClass], default: false
property :directory_mode, [String, Integer, Array], callbacks: {
  'should be numeric, ogu+rwx form or array of valid values' => lambda do |p|
    return true if p.is_a?(Integer) && p < 0o1000
    [p].flatten.compact.all? do |mode|
      mode =~ /\A([ugo]*[\+-][rwx]+|0[0-7]{3,4})\z/
    end
  end
}
property :file_mode, [String, Integer, Array] # (absolute value or + or -)
property :only_files, [TrueClass, FalseClass], default: false
property :only_directories, [TrueClass, FalseClass], default: false
property :force, [TrueClass, FalseClass], default: false
property :group, String
property :owner, String
property :quiet, [TrueClass, FalseClass], default: false

action_class do
  def whyrun_supported?
    true
  end

  include DirChangeHelper
  include DirDeleteHelper
end

action :create do
  changed = update_files(new_resource.path, new_resource.pattern, new_resource.recursive, new_resource.follow_symlink,
                         new_resource.directory_mode, new_resource.file_mode, new_resource.group, new_resource.owner,
                         new_resource.quiet, new_resource.only_files, new_resource.only_directories, Chef::Config[:why_run])
  converge_by("Update file #{new_resource.name}") {} if changed
end

action :delete do
  changed = delete_files(new_resource.path, new_resource.pattern, new_resource.follow_symlink,
                         new_resource.only_files, new_resource.force, new_resource.quiet, Chef::Config[:why_run])
  converge_by("Delete files #{new_resource.name}") {} if changed
end
