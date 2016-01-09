# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jgit/version'
require 'rake'

Gem::Specification.new do |spec|
  spec.name          = "jgit"
  spec.version       = Jgit::VERSION
  spec.authors       = ["jintin"]
  spec.email         = ["jintinapps@gmail.com"]

  spec.summary       = "git management tool"
  spec.description   = "Jgit is a tool to help you manage multiple separate git-base project in local file system."
  spec.homepage      = "https://github.com/Jintin/jgit"
  spec.license       = "MIT"

  spec.files = FileList['lib/*',
                        'lib/jgit/*',
                        'bin/*'].to_a
  spec.test_files = FileList['test/*'].to_a
	spec.bindir        = "bin"
  spec.executables   = "jgit"
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.8.0"
	spec.add_runtime_dependency "thor", "~> 0"
end
