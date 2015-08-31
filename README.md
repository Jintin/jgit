# jgit

[![Gem Version](https://badge.fury.io/rb/jgit.svg)](http://badge.fury.io/rb/jgit)
[![Build Status](https://travis-ci.org/Jintin/jgit.svg?branch=master)](https://travis-ci.org/Jintin/jgit)

jgit is a command line tool to help you manage multiple seperate git base project in local file system.
You can excute command all at once like `jgit status` `jgit fetch` `jgit pull` or any other command you want.

## Installation

Just install it by gem:

    $ gem install jgit

## Usage

The most commonly used command:

     $ jgit add <path> <name>         # add new task
     $ jgit list                      # list all tasks
     $ jgit remove <name>             # remove task
     $ jgit group [COMMAND]           # group management

You can use same command like git:
    
     $ jgit pull                      # git pull on every task
     $ jgit push                      # git push on every task
     $ jgit status                    # git status on every task
     $ jgit fetch                     # git fetch on every task
     
Or direct exec command:
     
     $ jgit exe <command...>          # exec command on each task
    
See `jgit help` or `jgit help <command>` for more information.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Jintin/jgit.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

