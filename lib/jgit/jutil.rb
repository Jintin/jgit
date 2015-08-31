#!/usr/bin/env ruby

def prompt(args, default = "")

	begin
		puts(args)
		print "> "
		STDOUT.flush
		text = STDIN.gets.chomp
	rescue SystemExit, Interrupt
		jexit
	end

	if text.empty?
		default
	else
		text
	end

end

def jexit(str = nil)
	if str.nil?
		puts "exit with 0"
	else
		puts str
	end
	exit
end

def bold(text)
	"\033[1;4m#{text}\033[0m"
end
