#
# Cookbook:: fileutils
# Resource:: default
#
# Copyright:: 2020, Sous-Chefs
# Licensed under the Apache License, Version 2.0 (the "License")
#

default_action :create
property :path, String, name_property: true
property :pattern, Regexp
property :recursive, [true, false], default: true
property :follow_symlink, [true, false], default: false
property :directory_mode, [String, Integer, Array], callbacks: {
  'should be numeric, ogu+rwx form or array of valid values' => lambda do |p|
    return true if p.is_a?(Integer)
    [p].flatten.compact.all? do |mode|
      mode =~ /\A([ugo]*[\+-][rwx]+)|((0|[bdox])*[\d_]+)\z/
    end
  end,
}
property :file_mode, [String, Integer, Array], callbacks: {
  'should be numeric, ogu+rwx form or array of valid values' => lambda do |p|
    return true if p.is_a?(Integer)
    [p].flatten.compact.all? do |mode|
      mode =~ /\A([ugo]*[\+-][rwx]+)|((0|[bdox])*[\d_]+)\z/
    end
  end,
}
property :only_files, [true, false], default: false
property :only_directories, [true, false], default: false
property :force, [true, false], default: false
property :group, String
property :owner, String
property :quiet, [true, false], default: false
unified_mode true

action_class do
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
