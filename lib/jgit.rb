#!/usr/bin/env ruby

require 'jgit/common'
require 'jgit/group'
require 'jgit/desc'
require 'jgit/version'
require 'thor'

module Jgit

	class Project < Thor

		PROMPT_TASK = "key in project name:"

		desc 'add <path> <name> [-g GROUP]', 'add new project'
		method_option :group, :aliases => '-g', :desc => "group to operate"

		def add(path = nil, name = nil)

			path = prompt("key in project path:(empty for current dir)", Dir.pwd) if path.nil?
			path = File.expand_path(path)
			jexit "no such dir" unless File.directory?(path)

			name = prompt("key in project name:(empty for current dir)", File.basename(Dir.getwd)) if name.nil?
			data = list(false, options[:group])
			data[name] = path

			save_data(project_path(options[:group]), data.to_json)

		end

		desc 'list [-g GROUP]', 'list all projects'
		method_option :group, :aliases => '-g', :desc => "group to operate"
		map ls: :list

		def list(show = true, group = nil)

			group = options[:group] unless options[:group].nil?
			group = get_current_group if group.nil?

			data = load_obj(project_path(group), Hash)
			if show
				data.each do |key, val|
					puts "#{key}: #{val}"
				end
			end
			data

		end

		desc 'remove <name> [-g GROUP]', 'remove project'
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
				jexit "no such project"
			else
				save_data(project_path(options[:group]), data.to_json)
			end

		end

		desc 'rename <name> <new_name> [-g GROUP]', 'rename project'
		method_option :group, :aliases => '-g', :desc => "group to operate"
		map rn: :rename

		def rename(name = nil, new_name = nil)
			if name.nil?
				data = list(true, options[:group])
				name = prompt(PROMPT_TASK)
			else
				data = list(false, options[:group])
			end

			new_name = prompt("key in new project name:", File.basename(Dir.getwd)) if new_name.nil?
			jexit "new_name exist" if data.include?(new_name)

			result = data.delete(name)

			if result.nil?
				jexit "no such project"
			else
				data[new_name] = result
				save_data(project_path(options[:group]), data.to_json)
			end
		end

		desc 'commit [-g GROUP | -p PROJECT]', 'git commit on given project'
		method_option :group, :aliases => '-g', :desc => "group to operate"
		method_option :project, :aliases => '-p', :desc => "project to operate"

		def commit
			exe "git commit ."
		end

		desc 'status [-g GROUP | -p PROJECT]', 'git status on given project'
		method_option :group, :aliases => '-g', :desc => "group to operate"
		method_option :project, :aliases => '-p', :desc => "project to operate"

		def status
			exe "git status"
		end

		desc 'fetch [-g GROUP | -p PROJECT]', 'git fetch on given project'
		method_option :group, :aliases => '-g', :desc => "group to operate"
		method_option :project, :aliases => '-p', :desc => "project to operate"

		def fetch
			exe "git fetch"
		end

		desc 'pull [-g GROUP | -p PROJECT]', 'git pull on given project'
		method_option :group, :aliases => '-g', :desc => "group to operate"
		method_option :project, :aliases => '-p', :desc => "project to operate"

		def pull
			exe "git pull"
		end

		desc 'push [-g GROUP | -p PROJECT]', 'git push on given project'
		method_option :group, :aliases => '-g', :desc => "group to operate"
		method_option :project, :aliases => '-p', :desc => "project to operate"

		def push
			exe "git push"
		end

		desc 'exe <command...> [-g GROUP | -p PROJECT]', 'exec command on given project'
		method_option :group, :aliases => '-g', :desc => "group to operate"
		method_option :project, :aliases => '-p', :desc => "project to operate"

		long_desc EXE_DESC

		def exe(command)
			list = list(false, options[:group])

			jexit "no project, use 'jgit add' to add project first" if list.empty?

			list.each do |name, path|
				if !options[:project].nil? && options[:project] != name
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

		desc 'version', 'version of jgit'
		map "-v" => :version
		map "--version" => :version

		def version
			puts "jgit #{Jgit::VERSION} -- jgit is a git management tool in Ruby"
			puts "visit https://github.com/Jintin/jgit for more information"
		end

		desc "group [COMMAND]", "group management"
		subcommand "group", Group

	end
end

if __FILE__ == $0
	Jgit::Project.start(ARGV)
end

