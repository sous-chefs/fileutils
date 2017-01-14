Description
===========

This cookbook provides the fileutils resource.  The resource can be used to set attributes 
on all of the files in a directory and subdirectory. We've had years of people 
complaining that the directory recursive mode, which is in fact a parent operation, does 
not work on subdirectories and files.  In this cookbook recursive refers to subdirectories
and the files contained inside them.

Requirements
============

Developed for Rhel and Solaris servers.


Resource Parameters
===================
The fileutils resource will accept two actions.  :change is used to modify ownership and permission mode bit settings.
:delete is used to remove files and directories. :delete always functions in a recursive mode.  

Action | Parameter | Use
------ | --------- | ---
:change | path     | Specify the starting path or file.
        | owner    | Set the owner of the files and directories to this value.
        | group    | Set the group of the files and directories to this value.
        | file_mode | Set the permission mode for files. Specify octal numbers or mode change symbols
        | directory_mode | Set the permission mode for directories. Specify octal numbers or mode change symbols
        | recursive | Boolean. Use subdirectory recursion. Default is true.
        | only_files | Boolean. Only change files. Default is false.
        | only_directories | Boolean. Only change directories. Default is false.
        | pattern | Regex. Match to filter the basename of files and directories.
        | follow_symlink | Boolean. Continue on past symlinks.  Serious footgun capacity.

Action | Parameter | Use
------ | --------- | ---
:delete | path     | Specify the starting path or file.
        | recursive | Delete always functions in recursive mode.
        | only_files | Boolean. Only delete files. Default is false.
        | pattern | Regex. Match to filter the basename of files and directories.
        | follow_symlink | Boolean. Continue on past symlinks.  Serious footgun capacity!
        | force | Boolean. Use the for option with FileUtils

Usage
=====
A good example of why you would use the fileutils resource would  be setting attributes on files and directories after dir and file have created things. Notice that fileutils and dir treat recursive as moving in opposite directions.

````
# Create some directories
dir '/export/home/my/stuff/deep' do
  recursive true  # creates parents
end
# Set the owner on multiple directories
fileutils '/export/home/my' do
  recursive true # set the children
  owner 'my'
end
# Empty a directory
fileutils '/export/home/my' do
  action :delete
end
````

Acknowlegments
=============

Seth Vargo - Vender gem technique https://sethvargo.com/using-gems-with-chef/
Samuel Gay - Walk gem https://github.com/samonzeweb/walk
