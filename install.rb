#!/usr/bin/env ruby

system "gem build jgit.gemspec"
system "gem uninstall jgit"
system "gem install jgit"
