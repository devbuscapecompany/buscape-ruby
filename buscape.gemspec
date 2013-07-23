# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "buscape/version"

Gem::Specification.new do |s|
  s.name        = "buscape"
  s.version     = Buscape::VERSION
  s.authors     = ["Estevao Mascarenhas"]
  s.email       = ["estevao.am@gmail.com"]
  s.homepage    = "http://github.com/estevaoam/buscape"
  s.summary     = %q{A lightweight wrapper for BuscaPe API.}
  s.description = %q{A lightweight wrapper for BuscaPe API.}

  s.rubyforge_project = "buscape"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.add_dependency("httparty", ">= 0.7.7")
  s.add_development_dependency("awesome_print")
  s.add_development_dependency("wirble")
end
