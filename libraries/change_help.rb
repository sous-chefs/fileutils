#
# Cookbook Name:: fileutils
# Library:: helper
#
# Copyright 2017 Nordstrom, Inc.
# Licensed under the Apache License, Version 2.0 (the "License")
#

# Utility methods to change directory and file attributes
module DirChangeHelper
  require 'etc'
  require 'find'

  # Permissions
  R = 0o444  # Read
  W = 0o222  # Write
  X = 0o111  # Search/execute
  SU = 0o4000 # Assign user
  SG = 0o2000 # Assign group
  T = 0o1000  # Sticky bit

  # Who
  U = 0o7700  # Owning user
  G = 0o7070  # Owning group
  O = 0o7007  # Others
  A = 0o7777  # Everyone

  def update_files(path, pattern, recursive, follow_symlink,
                   directory_mode, file_mode, group, owner,
                   quiet, only_files, only_directories, why_run)
    @path = path
    @pattern = pattern
    @recursive = recursive
    @follow_symlink = follow_symlink
    @directory_mode = directory_mode
    @file_mode = file_mode
    @group = group
    @owner = owner
    @quiet = quiet
    @why_run = why_run
    @only_files = only_files
    @only_directories = only_directories
    @uid = owner ? new_uid : -1
    @gid = group ? new_gid : -1
    @changed = false
    find_and_update_files(@path)
    @changed
  end

  def find_and_update_files(path)
    if ::File.directory?(path) && @recursive
      ::Find.find(path) { |node| update(node) }
    # Update files and directories in the top path directory.
    elsif ::File.directory?(path)
      ::Find.find(path) do |node|
        update(node)
        ::Find.prune if path != node && ::File.directory?(node)
      end
    # Process a single file
    else
      update(path)
    end
  end

  def update(path)
    raise 'Tried to update root /' if path == '/'
    return if @pattern && ::File.basename(path) !~ @pattern
    fs = ::File.lstat(path)
    if fs.directory? && !@only_files
      mode = new_mode(fs.mode, @directory_mode)
      file_update(path, mode) if file_check(fs, mode)
    elsif fs.file? && !@only_directories
      mode = new_mode(fs.mode, @file_mode)
      file_update(path, mode) if file_check(fs, mode)
    elsif fs.symlink?
      ::Find.prune unless @follow_symlink
      find_and_update_files(::File.readlink(path))
    end
  end

  def file_update(path, mode)
    Chef::Log.info("Path #{path} updated mode #{mode} owner #{@uid} group #{@gid}") unless @quiet
    @changed = true
    return if @why_run
    f = ::File.new(path)
    f.chmod(mode)
    f.chown(@uid, @gid)
  end

  def file_check(fs, mode)
    changed = false
    changed = true unless fs.mode == new_mode(fs.mode, mode)
    changed = true unless fs.uid == @uid || @uid == -1
    changed = true unless fs.gid == @gid || @gid == -1
    changed
  end

  def new_mode(mode, settings)
    calc_mode = mode
    [settings].flatten.compact.each do |setting|
      calc_mode = case setting
                  when /\+/
                    calc_mode | mode_mask(setting)
                  when /-/
                    calc_mode & ~mode_mask(setting)
                  when nil
                    calc_mode
                  else
                    setting
                  end
    end
    calc_mode
  end

  def mode_mask(setting)
    who_mask(setting) & prm_mask(setting)
  end

  def new_uid
    Etc.getpwnam(@owner).uid
  end

  def new_gid
    Etc.getgrnam(@group).gid
  end

  def who_mask(setting)
    who = 0
    who |= U | G | O if setting =~ /^(\+|-|a)/
    who |= U if setting =~ /u/
    who |= G if setting =~ /g/
    who |= O if setting =~ /o/
    who
  end

  def prm_mask(setting)
    access = 0
    access |= R if setting =~ /r/
    access |= W if setting =~ /w/
    access |= X if setting =~ /x/
    access |= T if setting =~ /t/
    access |= SU if setting =~ /s.*u/
    access |= SG if setting =~ /s.*g/
    access
  end
end
