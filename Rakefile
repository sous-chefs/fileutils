require 'rubocop/rake_task'
require 'rspec/core/rake_task'

RuboCop::RakeTask.new do |rubocop|
  rubocop.options = ['-D']
end

RSpec::Core::RakeTask.new

desc 'Run all unit tests'
task test: %i(spec)

desc 'Code coverage'
task coverage: [:spec]

task default: :test
