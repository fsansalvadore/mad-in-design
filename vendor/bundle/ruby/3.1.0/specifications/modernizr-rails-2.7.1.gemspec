# -*- encoding: utf-8 -*-
# stub: modernizr-rails 2.7.1 ruby lib

Gem::Specification.new do |s|
  s.name = "modernizr-rails".freeze
  s.version = "2.7.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Russ Frisch".freeze]
  s.date = "2014-01-15"
  s.description = "This Modernizr.js was built using the at http://www.modernizr.com/download/ with all options enabled.".freeze
  s.email = ["russfrisch@shortmail.com".freeze]
  s.homepage = "http://rubygems.org/gems/modernizr-rails".freeze
  s.rubygems_version = "3.3.7".freeze
  s.summary = "Gem wrapper to include the Modernizr.js library via the asset pipeline.".freeze

  s.installed_by_version = "3.3.7" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_development_dependency(%q<rails>.freeze, [">= 3.1.0"])
  else
    s.add_dependency(%q<rails>.freeze, [">= 3.1.0"])
  end
end
