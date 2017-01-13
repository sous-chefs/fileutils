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

Acknowlegments
=============

Seth Vargo - Vender gem technique + link
?????      - Walk gem
