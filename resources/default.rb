#
# Cookbook:: fileutils
# Resource:: default
#
# Copyright 2017, Nordstrom, Inc.
#

default_action :create
property :path, String, name_property: true
property :pattern, Regexp
property :recursive, [TrueClass, FalseClass], default: true
property :follow_symlink, [TrueClass, FalseClass], default: false
property :directory_mode, [String, Integer, Array], callbacks: {
  'should be numeric, ogu+rwx form or array of valid values' => lambda do |p|
    return true if p.is_a?(Integer) && p < 01000
    [p].flatten.compact.all? do |mode|
      mode =~ /\A([ugo]*[\+-][rwx]+|0[0-7]{3,3})\z/
    end
  end
}
property :file_mode, [String, Fixnum, Array] # (absolute value or + or -)
property :only_files, [TrueClass, FalseClass], default: false
property :only_directories, [TrueClass, FalseClass], default: false
property :group, String
property :owner, String

action_class do
  include DirHelper
end

action :create do
  changed = update_files(path, pattern, recursive, follow_symlink,
                         directory_mode, file_mode, group, owner,
                         only_files, only_directories, Chef::Config[:why_run]
                        )
  new_resource.updated_by_last_action(true) if changed
end

action :delete do
  puts "Resource #{path} only #{only_files}"
  changed = delete_files(path, pattern, recursive, follow_symlink,
                         only_files, Chef::Config[:why_run]
                        )
  new_resource.updated_by_last_action(true) if changed
end
