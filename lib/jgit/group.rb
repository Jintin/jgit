#!/usr/bin/env ruby

require 'jgit/common'
require 'thor'

module Jgit
	class Group < Thor

		PROMPT_GROUP = "key in group name:"

		desc 'add <name>', 'add new group'

		def add(name = nil)

			name = prompt(PROMPT_GROUP) if name.nil?
			jexit "no such group" if name.empty?

			data = list(false)
			data.push(name) unless data.include?(name)
			save_data(GROUP_DATA, data.to_json)

		end

		desc 'list', 'list group'
		map ls: :list

		def list(show = true)

			current = load_data(CURRENT_GROUP)
			current = "default" if current.empty?

			data = load_obj(GROUP_DATA, Array)
			data.unshift("default")

			if show
				data.each do |val|
					puts((val == current ? "> " : "  ") + val)
				end
			end

			data.delete("default")
			data

		end

		desc 'remove <name>', 'remove group'
		map rm: :remove

		def remove(name)

			name = select_group(name)
			data = list(false)

			if data.delete(name).nil?
				jexit name == "default" ? "can't remove default group" : "no such group"
			else
				delete_file(CURRENT_GROUP) if name == load_data(CURRENT_GROUP)
				delete_file(project_path(name))

				save_data(GROUP_DATA, data.to_json)
			end

		end

		desc 'rename <name> <new_name>', 'rename group'

		def rename(name = nil, new_name = nil)

			name = select_group(name)
			data = list(false)

			new_name = prompt("key in group name:") if new_name.nil?
			jexit "new_name exist" if data.include?(new_name)

			if data.delete(name).nil?
				jexit "no such group"
			else
				save_data(CURRENT_GROUP, new_name) if name == load_data(CURRENT_GROUP)
				data.push(new_name)
				save_data(GROUP_DATA, data.to_json)
			end

		end

		no_commands do
			def select_group(name = nil)
				if name.nil?
					list
					name = prompt(PROMPT_GROUP)
				end
				name
			end
		end

	end
end
