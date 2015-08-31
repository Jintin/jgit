#!/usr/bin/env ruby

require 'jgit/jutil'
require 'json'

FOLDER_PATH = "#{Dir.home}/.jgit"
GROUP_DATA = "#{FOLDER_PATH}/group.json"
CURRENT_GROUP = "#{FOLDER_PATH}/current.json"

def task_path(current = nil)
	current = load_data(CURRENT_GROUP) unless current.nil?
	"#{FOLDER_PATH}/record_#{current}.json"
end

def get_current_group
	if File.exists?(CURRENT_GROUP)
		File.read(CURRENT_GROUP)
	else
		""
	end
end

def delete_file(file)
	if File.exist?(file)
		File.delete(file)
	end
end

def save_data(path, data)
	unless File.exist?(FOLDER_PATH)
		FileUtils.mkdir_p(FOLDER_PATH)
	end
	File.open(path, 'w+') do |f|
		f.write(data)
	end
end

def load_data(path)
	if File.exists?(path)
		File.read(path)
	else
		""
	end
end

def load_obj(path, cls)
	if File.exists?(path)
		file = File.read(path)
		JSON.parse(file)
	else
		cls.new
	end
end
