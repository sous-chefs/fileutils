Description
===========

This cookbook provides the fileutils resource.  The resource can be used to set attributes 
on all of the files in a directory and subdirectory. We've had years of people 
complaining that the directory recursive mode, which is in fact a parent operation, does 
not work on subdirectories and files.  In this cookbook recursive refers to subdirectories
and the files contained inside them.

Requirements
============

Developed for RHEL and Solaris servers.


Resource Parameters
===================
The fileutils resource will accept two actions.  :change is used to modify ownership and permission mode bit settings.
:delete is used to remove files and directories. :delete always functions in a recursive mode.  

| Action | Parameter | Use
| ------ | --------- | ---
| :change | path     | Specify the starting path or file. The path must exist for anything to be done.
|        | owner    | Set the owner of the files and directories to this value.
|        | group    | Set the group of the files and directories to this value.
|        | file_mode | Set the permission mode for files. Specify octal numbers or mode change symbols
|        | directory_mode | Set the permission mode for directories. Specify octal numbers or mode change symbols
|        | recursive | Boolean. Use top down traversal from the starting path. Default is true. When recursive is false only the initial directory and contents are changed.
|        | only_files | Boolean. Only change files. Default is false.
|        | only_directories | Boolean. Only change directories. Default is false.
|        | pattern | Regex. Match to filter the basename of files and directories.
|        | follow_symlink | Boolean. Continue on past symlinks.  Serious footgun capacity. Default is false.
|        | quiet | Boolean. Supress output for changing each file. Default is false.

| Action | Parameter | Use
| ------ | --------- | ---
| :delete | path     | Specify the starting path or file.
|         | recursive | Delete always functions in recursive mode.
|         | only_files | Boolean. Only delete files. Default is false.
|         | pattern | Regex. Match to filter the basename of files and directories.
|         | follow_symlink | Boolean. Continue on past symlinks.  Serious footgun capacity!
|         | force | Boolean. Use the for option with FileUtils.
|         | quiet | Boolean. Supress output for deleting each file. Default is false.

Mode bit symbolic settings.
==========================
 
You can use symbolic settings. Pick who and add or subtract access permissions. The code tries to mimic the chmod command.

Who  
---

*  u Owning user
*  g Owning group
*  o Others
*  a Everyone

Permissions
-----------

*  r Read
*  w Write
*  x Search/execute
*  s Assign user
*  t Sticky bit

Examples.
---------

*  '+r'  Adds read permissions to all files
*  'g+r' Adds read permissions for the group to all files
*  'o-w' Removes write permissions for other from all files

Usage
=====
A good example of why you would use the fileutils resource would  be setting attributes on files and directories after dir and file have created things. Notice that fileutils and dir treat recursive as moving in opposite directions.

````
# Create some directories
dir '/export/home/my/stuff/deep' do
  recursive true  # creates parents
end

# Set the owner on multiple directories
fileutils '/export/home/my' do # Set the child nodes
  owner 'my'
end

# Empty a directory
fileutils '/export/home/my' do
  action :delete
end

# Set mode attributes
fileutils '/export/home/my' do # Set the child nodes
  file_mode ['o+r', 'g+w'] 
  directory_mode ['o+rx', 'g+wrx'] 
end

# Change only the top level directory and it's files
# should not change .../stuff/**
fileutils '/export/home/my' do
  recursive false
  files_only true
  file_mode ['0700']
end
````

Author
======
* Mark Gibbons


Acknowlegments
=============

*  Seth Vargo - Vender gem technique https://sethvargo.com/using-gems-with-chef/
*  Samuel Gay - Walk gem https://github.com/samonzeweb/walk
