
# CHANGELOG for fileutils

This file is used to list changes made in each version of the COOKBOOK_NAME
cookbook.

## Unreleased

- Remove delivery folder

## 2.1.1 - *2022-01-18*

## 2.1.0 - *2021-08-16*

## 2.0.1 - *2021-06-01*

## 2.0.0 - *2021-05-24*

- resolved cookstyle error: libraries/delete_help.rb:11:32 convention: `Style/ExpandPathArguments`
- resolved cookstyle error: spec/unit/libraries/dir_spec.rb:1:9 convention: `Style/RedundantFileExtensionInRequire`
- support Chef 17
- minimum Chef version is 15.3

## 1.4.0 (2020-07-31)

- Add rspec testing to the github actions
- Add integration testing to the github actions
- resolved cookstyle error: resources/default.rb:12:1 refactor: `ChefStyle/TrueClassFalseClassResourceProperties`
- resolved cookstyle error: resources/default.rb:13:1 refactor: `ChefStyle/TrueClassFalseClassResourceProperties`
- resolved cookstyle error: resources/default.rb:30:1 refactor: `ChefStyle/TrueClassFalseClassResourceProperties`
- resolved cookstyle error: resources/default.rb:31:1 refactor: `ChefStyle/TrueClassFalseClassResourceProperties`
- resolved cookstyle error: resources/default.rb:32:1 refactor: `ChefStyle/TrueClassFalseClassResourceProperties`
- resolved cookstyle error: resources/default.rb:35:1 refactor: `ChefStyle/TrueClassFalseClassResourceProperties`

## 1.3.0

- Try to treat the mode settings for files and groups more consistently.
- Allow numeric and string settings for mode values
- Cookstyle updates

## 1.2.0

- Add a quite option to turn off the detail output from file changes and deletes

## 1.1.7

- Change the cookbook description

## 1.1.6

- Fix setting the gid and uid

## 1.1.5

- Add Travis tests

## 1.1.4

- Add contributers and testing files.
- metadata changes to pass quality metrics

## 1.1.3

- Apache license in metadata

## 1.1.2

- Minor clean up, add author

## 1.1.0

- Clean up what recursive means

## 1.0.2

- Support chefci (now being sent to internal supermarket via chefci)

## 1.0.1

- Fix boundary condition bugs

## 1.0.0

- Initial version
