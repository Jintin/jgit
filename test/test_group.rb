#!/usr/bin/env ruby

require 'minitest/autorun'
require 'jgit/common'
require 'jgit/group'
require 'jgit'

class GroupTest < Minitest::Unit::TestCase

	def test_add

		jgit = Jgit::Group.new
		jgit.add("test")
		data = jgit.list(false)
		jgit.remove("test")
		assert data.include?("test")

	end

	def test_remove

		jgit = Jgit::Group.new
		jgit.add("test")
		data = jgit.list(false)
		jgit.remove("test")
		data2 = jgit.list(false)
		assert data.include?("test") && !data2.include?("test")

	end

	def test_rename

		jgit = Jgit::Group.new
		jgit.add("test")
		jgit.rename("test", "newtest")
		data = jgit.list(false)
		jgit.remove("newtest")
		assert !data.include?("test") && data.include?("newtest")

	end

	def test_chgrp
		task = Jgit::Project.new
		group = Jgit::Group.new

		current = load_data(CURRENT_GROUP)
		group.add("test")
		task.chgrp("test")
		task.add(".","test")
		data = task.list(false)
		task.remove("test")
		task.chgrp(current)
		data2 = task.list(false)
		group.remove("test")
		assert data.include?("test") && !data2.include?("test")

	end

end