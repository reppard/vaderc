require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'

desc 'Run specs'
RSpec::Core::RakeTask.new(:spec)

desc 'Run RuboCop'
RuboCop::RakeTask.new(:rubocop) do |t|
  t.patterns = [
    'lib/**/*.rb',
    'spec/**/*.rb'
  ]
  t.fail_on_error = true
end

desc 'Specs and rubocop'
task combo: [:spec, :rubocop]

task default: :combo
