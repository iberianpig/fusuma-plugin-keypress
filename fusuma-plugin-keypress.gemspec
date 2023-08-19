# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "fusuma/plugin/keypress/version"

Gem::Specification.new do |spec|
  spec.name = "fusuma-plugin-keypress"
  spec.version = Fusuma::Plugin::Keypress::VERSION
  spec.authors = ["iberianpig"]
  spec.email = ["yhkyky@gmail.com"]

  spec.summary = "Keypress plugin for Fusuma "
  spec.description = "fusuma-plugin-keypress is Fusuma plugin for keypress combination."
  spec.homepage = "https://github.com/iberianpig/fusuma-plugin-keypress"
  spec.license = "MIT"

  # Specify which files should be added to the gem when it is released.
  spec.files = Dir["{bin,lib,exe}/**/*", "LICENSE*", "README*", "*.gemspec"]
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 2.5.1" # https://packages.ubuntu.com/search?keywords=ruby&searchon=names&exact=1&suite=all&section=main
  # support bionic (18.04LTS) 2.5.1
  spec.add_dependency "fusuma", ">= 2.0"
  spec.metadata = {
    "rubygems_mfa_required" => "true"
  }
end
