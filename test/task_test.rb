#!/usr/bin/env ruby

require 'minitest/autorun'
require 'jgit/common'
require 'jgit'

class TaskTest < Minitest::Test

	def test_add

		jgit = Jgit::Project.new
		jgit.add(".", "test")
		data = jgit.list(false)
		jgit.remove("test")
		assert_equal File.expand_path("."), data["test"]
	end

	def test_remove

		jgit = Jgit::Project.new
		jgit.add(".", "test")
		data = jgit.list(false)
		jgit.remove("test")
		data2 = jgit.list(false)
		assert !data["test"].nil? && data2["test"].nil?

	end

	def test_rename

		jgit = Jgit::Project.new
		jgit.add(".", "test")
		jgit.rename("test", "newtest")
		data = jgit.list(false)
		jgit.remove("newtest")
		assert data["test"].nil? && !data["newtest"].nil?

	end

end