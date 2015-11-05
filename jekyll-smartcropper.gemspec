# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "jekyll-smartcropper/version"

Gem::Specification.new do |s|
  s.name        = "jekyll-smartcropper"
  s.version     = Jekyll::SmartCropper::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Josh Gerdes"]
  s.email       = ["josh@joshgerdes.com"]
  s.homepage    = "http://github.com/joshgerdes/jekyll-smartcropper"
  s.summary     = %q{Smartcropper Image Generator for Jekyll}
  s.description = %q{Use smartcropper and rmagick to crop and resize images in your Jekyll project.}

  s.rubyforge_project = "jekyll-smartcropper"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency('jekyll', [">= 3.0.0"])
  s.add_runtime_dependency('smartcropper', [">= 0.7.1"])
  s.add_runtime_dependency('rmagick', ["> 2.11.0"])
end