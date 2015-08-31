#!/usr/bin/env ruby

require "bundler/gem_tasks"
require 'rake/testtask'

Rake::TestTask.new do |t|
	# t.libs << 'test'
	t.test_files = FileList['test/*'].to_a
end

desc "Run tests"
task :default => :test