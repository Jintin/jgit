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
  spec.description   = "Jgit is a tool to help you manage multiple seperate git-base project in local file system."
  spec.homepage      = "https://github.com/Jintin/jgit"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  # else
  #   raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  # end

  spec.files = FileList['lib/*',
                        'lib/jgit/*',
                        'bin/*'].to_a
  # spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.test_files = FileList['test/*'].to_a
	spec.bindir        = "bin"
  spec.executables   = "jgit"
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
	spec.add_runtime_dependency "thor", "~> 0"
end
