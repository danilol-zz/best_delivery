require 'bundler/setup'
Bundler.require

Dir[File.join(File.dirname(__FILE__), 'tasks/*')].each { |f| load f }

$:.unshift(File.dirname(__FILE__) + '/../../lib')
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task :default => [:spec]
