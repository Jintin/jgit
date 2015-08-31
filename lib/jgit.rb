#!/usr/bin/env ruby

require 'jgit/common'
require 'jgit/group'
require 'jgit/desc'
require 'thor'

module Jgit

	class Task < Thor

		PROMPT_TASK = "key in task name:"

		desc 'add <path> <name>', 'add new task'
		method_option :group, :aliases => '-g', :desc => "group to operate"

		def add(path = nil, name = nil)

			path = prompt("key in task path:(empty for current dir)", Dir.pwd) if path.nil?
			path = File.expand_path(path)
			jexit "no such dir" unless File.directory?(path)

			name = prompt("key in task name:(empty for current dir)", File.basename(Dir.getwd)) if name.nil?
			data = list(false, options[:group])
			data[name] = path

			save_data(task_path(options[:group]), data.to_json)

		end

		desc 'list', 'list all tasks'
		method_option :group, :aliases => '-g', :desc => "group to operate"
		map ls: :list

		def list(show = true, group = nil)

			group = options[:group] unless options[:group].nil?
			data = load_obj(task_path(group), Hash)
			if show
				data.each do |key, val|
					puts "#{key}: #{val}"
				end
			end
			data

		end

		desc 'remove <name>', 'remove task'
		method_option :group, :aliases => '-g', :desc => "group to operate"
		map rm: :remove

		def remove(name = nil)

			if name.nil?
				data = list(true, options[:group])
				name = prompt(PROMPT_TASK)
			else
				data = list(false, options[:group])
			end

			if data.delete(name).nil?
				jexit "no such task"
			else
				save_data(task_path(options[:group]), data.to_json)
			end

		end

		desc 'rename <name> <new_name>', 'rename task'
		method_option :group, :aliases => '-g', :desc => "group to operate"
		map rn: :rename

		def rename(name = nil, new_name = nil)
			if name.nil?
				data = list(true, options[:group])
				name = prompt(PROMPT_TASK)
			else
				data = list(false, options[:group])
			end

			new_name = prompt("key in new task name:", File.basename(Dir.getwd)) if new_name.nil?
			jexit "new_name exist" if data.include?(new_name)

			result = data.delete(name)

			if result.nil?
				jexit "no such task"
			else
				data[new_name] = result
				save_data(task_path(options[:group]), data.to_json)
			end
		end

		desc 'status', 'git status on every task'
		method_option :group, :aliases => '-g', :desc => "group to operate"
		method_option :task, :aliases => '-t', :desc => "task to operate"

		def status
			exe "git status"
		end

		desc 'fetch', 'git fetch on every task'
		method_option :group, :aliases => '-g', :desc => "group to operate"
		method_option :task, :aliases => '-t', :desc => "task to operate"

		def fetch
			exe "git fetch"
		end

		desc 'pull', 'git pull on every task'
		method_option :group, :aliases => '-g', :desc => "group to operate"
		method_option :task, :aliases => '-t', :desc => "task to operate"

		def pull
			exe "git pull"
		end

		desc 'push', 'git push on every task'
		method_option :group, :aliases => '-g', :desc => "group to operate"
		method_option :task, :aliases => '-t', :desc => "task to operate"

		def push
			exe "git push"
		end

		desc 'exe <command...>', 'exec command on every task'
		method_option :group, :aliases => '-g', :desc => "group to operate"
		method_option :task, :aliases => '-t', :desc => "task to operate"

		long_desc EXE_DESC

		def exe(command)
			list = list(false, options[:group])

			jexit "no task, use 'jgit add' to add task first" if list.empty?

			list.each do |name, path|
				if !options[:task].nil? && options[:task] != name
					next
				end
				puts ""
				puts " - Task:#{bold(name)}"
				Dir.chdir(path)
				system command
			end
		end

		desc 'chgrp <name>', 'change default group'
		map cg: :chgrp

		def chgrp(name = nil)

			group = Group.new
			name = group.select_group(name)
			data = group.list(false)

			name = "" if name == "default"

			if name.empty? || data.include?(name)
				puts "switch to #{name} group"
				save_data(CURRENT_GROUP, name)
			else
				jexit "no such group"
			end
		end

		desc "group [COMMAND]", "group management"
		subcommand "group", Group

	end
end

if __FILE__ == $0
	Jgit::Task.start(ARGV)
end

