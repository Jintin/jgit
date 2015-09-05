# jgit

[![Gem Version](https://badge.fury.io/rb/jgit.svg)](http://badge.fury.io/rb/jgit)
[![Build Status](https://travis-ci.org/Jintin/jgit.svg?branch=master)](https://travis-ci.org/Jintin/jgit)

jgit is a command line tool to help you manage multiple separate git base project in local file system.
You can execute command all at once like `jgit status` `jgit fetch` `jgit pull` or any other command you want.

## Installation

Just install it by gem:

    $ gem install jgit

## Usage

The most commonly used command:

     $ jgit add <path> <name> [-g GROUP]              # add new project
     $ jgit list [-g GROUP]                           # list all projects, alias: ls
     $ jgit remove <name> [-g GROUP]                  # remove project, alias: rm
     $ jgit group [COMMAND]                           # group management
     $ jgit chgrp <name>                              # change default group
     $ jgit rename <name> <new_name> [-g GROUP]       # rename project, alias: rn 

You can use same command like git:
    
     $ jgit commit [-g GROUP] [-p PROJECT]            # git commit on given project, alias: co
     $ jgit fetch [-g GROUP] [-p PROJECT]             # git fetch on given project
     $ jgit pull [-g GROUP] [-p PROJECT]              # git pull on given project
     $ jgit push [-g GROUP] [-p PROJECT]              # git push on given project
     $ jgit status [-g GROUP] [-p PROJECT]            # git status on given project, alias: st

Or direct exec command:
     
     $ jgit exe <command...> [-g GROUP] [-p PROJECT]  # exec command on given project
     
See `jgit help` or `jgit help <command>` for more information.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Jintin/jgit.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

