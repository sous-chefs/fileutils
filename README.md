Description
===========

This cookbook provides the fileutils resource.  The resource can be used to set attributes 
on all of the files in a directory and subdirectory.

Requirements
============

Developed for Rhel and Solaris servers.


Resource Parameters
===================
path
owner
group
file_mode  (absolute value or + or -)
directory_mode (absolute value or + or -)
recursive boolean
only_files boolean
only_directories boolean

Usage
=====
