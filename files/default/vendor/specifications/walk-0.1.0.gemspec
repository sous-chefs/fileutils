# -*- encoding: utf-8 -*-
# stub: walk 0.1.0 ruby lib

Gem::Specification.new do |s|
  s.name = 'walk'.freeze
  s.version = '0.1.0'

  s.required_rubygems_version = Gem::Requirement.new('>= 0'.freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ['lib'.freeze]
  s.authors = ['Samuel GAY'.freeze]
  s.date = '2014-01-25'
  s.email = ['sam.onzeweb@gmail.com'.freeze]
  s.homepage = ''.freeze
  s.licenses = ['MIT'.freeze]
  s.rubygems_version = '2.6.7'.freeze
  s.summary = 'Directory tree traversal tool inspired by python os.walk'.freeze

  s.installed_by_version = '2.6.7' if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0')
      s.add_development_dependency('bundler'.freeze, ['~> 1.5'])
      s.add_development_dependency('rake'.freeze, ['>= 0'])
      s.add_development_dependency('rspec'.freeze, ['~> 2.14'])
    else
      s.add_dependency('bundler'.freeze, ['~> 1.5'])
      s.add_dependency('rake'.freeze, ['>= 0'])
      s.add_dependency('rspec'.freeze, ['~> 2.14'])
    end
  else
    s.add_dependency('bundler'.freeze, ['~> 1.5'])
    s.add_dependency('rake'.freeze, ['>= 0'])
    s.add_dependency('rspec'.freeze, ['~> 2.14'])
  end
end
