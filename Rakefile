#!/usr/bin/env ruby

require "bundler/gem_tasks"
require 'rake/testtask'

# Rake::TestTask.new do |t|
# 	# t.libs << 'test'
# 	t.test_files = FileList['test/*'].to_a
# end

Rake::TestTask.new(:test) do |t|
	t.test_files = Dir['**/*_test.rb'].reject do |path|
		path.include?('vendor')  # tell travis CI to ignore vendor tests
	end
end

desc "Run tests"
task :default => :test