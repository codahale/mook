# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "mook/version"

Gem::Specification.new do |s|
  s.name        = "mook"
  s.version     = Mook::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Coda Hale"]
  s.email       = ["coda.hale@gmail.com"]
  s.homepage    = "https://github.com/codahale/mook"
  s.summary     = %q{Yet another damn site generator thing.}
  s.description = %q{Generates static HTML files from Markdown. But, like, well.}
  s.add_dependency('redcarpet', '>= 2.1.0')
  s.add_dependency('pygments.rb', '>= 0.2.4')

  s.rubyforge_project = "mook"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
