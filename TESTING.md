# Testing

## Testing methods used

* Unit tests: rspec
* Integration tests: Test Kitchen and serverspec
* Chef Style Linting: foodcritic
* Ruby Style Linting: rubocop -a

## Prerequisites

You can install the [Chef Development Kit (Chef-DK)](http://downloads.chef.io/chef-dk/) to more easily install the above components.

You must also have Vagrant and VirtualBox installed:

- [Vagrant](https://vagrantup.com)
- [VirtualBox](https://virtualbox.org)

## Development

1. Clone the git repository from Github:

   - `git clone git@github.com:nordstrom/fileutile-cookbook.git`

2. Create a branch for your changes:

   - `git checkout -b fix_branch`

3. Make changes.
4. Write tests to support those changes.  Please write regression tests for bug fixes and functional tests for new features.
5. Run the tests:

  - `rubocop -a`
  - `foodcritic .`
  - `rspec`
  - `kitchen test`

6. Assuming the tests pass, open a pull request on github.com/nordstrom/fileutils-cookbook
