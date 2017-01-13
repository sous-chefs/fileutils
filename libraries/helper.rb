#
# Cookbook Name:: fileutils
# Library:: helper
#
# Copyright 2017 Nordstrom, Inc.
#
# All rights reserved - Do Not Redistribute

# Utility methods to change directory and file attributes
module DirHelper
  $LOAD_PATH.unshift *Dir[File.expand_path('../../files/default/vendor/gems/**/lib', __FILE__)]
  require 'etc'
  require 'find'
  require 'walk'
  R = 0444
  W = 0222
  X = 0111
  O = 0700
  G = 0070
  U = 0007

  def update_files(path, pattern, recursive, follow_symlink,
                   directory_mode, file_mode, group, owner,
                   only_files, only_directories, why_run
                  )
    @path = path
    @pattern = pattern
    @recursive = recursive
    @follow_symlink = follow_symlink
    @directory_mode = directory_mode
    @file_mode = file_mode
    @group = group
    @owner = owner
    @why_run = why_run
    @only_files = only_files
    @only_directories = only_directories
    @uid = new_uid
    @gid = new_gid
    @changed = false
    find_and_update_files(@path)
    @changed
  end

  def delete_files(path, pattern, recursive, follow_symlink, only_files, why_run)
    @path = path
    @pattern = pattern
    @recursive = recursive
    @follow_symlink = follow_symlink
    @only_files = only_files
    @why_run = why_run
    find_and_delete_file(path)
    @changed
  end

  def find_and_update_files(path)
    if ::File.directory?(path) && @recursive
      ::Find.find(path) do |node|
        update(node)
      end
    else
      update(path)
    end
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
      next if @pattern && File.basename(path) !~ @pattern
      Chef::Log.info("Path #{f} deleted")
      @changed = true
      ::FileUtils.remove_entry_secure(f) if ::File.exist?(f)
    end
  end

  def update(path)
    return if @pattern && ::File.basename(path) !~ @pattern
    fs = ::File.lstat(path)
    case
    when fs.directory? && ! @only_files
      mode = new_mode(fs.mode, @directory_mode)
      file_update(path, mode) if file_check(fs, mode)
    when fs.file? && ! @only_directories
      mode = new_mode(fs.mode, @file_mode)
      file_update(path, mode) if file_check(fs, mode)
    when fs.symlink?
      ::Find.prune unless @follow_symlink
      find_and_update_files(::File.readlink(path))
    end
  end

  def file_update(path, mode)
    Chef::Log.info("Path #{path} updated mode #{mode} owner #{@uid} group #{@gid}")
    @changed = true
    return if Chef::Config[:why_run]
    f = ::File.new(path)
    f.chmod(mode)
    f.chown(@uid, @gid)
  end

  def file_check(fs, mode)
    change = false
    change = true unless fs.mode == new_mode(fs.mode, mode)
    change = true unless fs.uid == @uid
    change = true unless fs.gid == @gid
    change
  end

  def new_mode(mode, settings)
    calc_mode = mode
    [settings].flatten.compact.each do |setting|
      calc_mode = case setting
                  when /\+/
                    calc_mode | mode_mask(setting)
                  when /-/
                    calc_mode & ~mode_mask(setting)
                  else
                    (calc_mode & ~0777 | setting)
                  end
    end
    calc_mode
  end

  def mode_mask(setting)
    access_mask(setting) & who_mask(setting)
  end

  def new_uid
    Etc.getpwnam(@owner).uid
  end

  def new_gid
    Etc.getgrnam(@group).gid
  end

  def access_mask(setting)
    access = 0
    access |= O | G | U if setting =~ /^(\+|-)/
    access |= O if setting =~ /o/
    access |= G if setting =~ /g/
    access |= U if setting =~ /u/
    access
  end

  def who_mask(setting)
    who = 0
    who |= R if setting =~ /r/
    who |= W if setting =~ /w/
    who |= X if setting =~ /x/
    who
  end
end
