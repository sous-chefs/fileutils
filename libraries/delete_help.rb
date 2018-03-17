#
# Cookbook Name:: fileutils
# Library:: helper
#
# Copyright 2017 Nordstrom, Inc.
# Licensed under the Apache License, Version 2.0 (the "License")
#

# Utility methods to change directory and file attributes
module DirDeleteHelper
  $LOAD_PATH.unshift(*Dir[File.expand_path('../../files/default/vendor/gems/**/lib', __FILE__)])
  require 'walk'

  def delete_files(path, pattern, follow_symlink, only_files, force, quiet, why_run)
    @path = path
    @pattern = pattern
    @follow_symlink = follow_symlink
    @only_files = only_files
    @force = force
    @quiet = quiet
    @why_run = why_run
    @changed = false
    find_and_delete_file(path)
    @changed
  end

  def find_and_delete_file(node)
    Walk.walk(node, topdown: false, followlinks: @follow_symlink).each do |path, dirs, files|
      rm_files(files, path)
      rm_files(dirs, path) unless @only_files
      rm_files([path], '') unless @only_files
    end
  end

  def rm_files(files, path)
    files.each do |file|
      f = ::File.join(path, file)
      raise 'Tried to delete root /' if f == '/'
      next if @pattern && File.basename(path) !~ @pattern
      Chef::Log.info("Path #{f} deleted") unless @quiet
      @changed = true
      next if @why_run
      ::FileUtils.remove_entry_secure(f, force: @force) if ::File.exist?(f)
    end
  end
end
