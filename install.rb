#!/usr/bin/env ruby

system "gem build jgit.gemspec"
system "sudo gem uninstall jgit"
system "sudo rake install jgit"
