# -*- encoding: utf-8 -*-
# stub: jquery-slick-rails 1.10.0 ruby lib

Gem::Specification.new do |s|
  s.name = "jquery-slick-rails".freeze
  s.version = "1.10.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Ilya Bodrov".freeze]
  s.date = "2021-12-13"
  s.description = "Integrates Slick carousel, a jQuery plugin by Ken Wheeler, into your Rails app. THIS GEM IS DEPRECATED.".freeze
  s.email = ["golosizpru@gmail.com".freeze]
  s.homepage = "https://github.com/bodrovis/jquery-slick-rails".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.3.7".freeze
  s.summary = "Integrates Slick carousel into Rails app.".freeze

  s.installed_by_version = "3.3.7" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<railties>.freeze, [">= 3.1"])
    s.add_development_dependency(%q<rails>.freeze, ["= 7.0.0.rc1"])
    s.add_development_dependency(%q<sprockets-rails>.freeze, ["~> 3.4"])
    s.add_development_dependency(%q<test-unit>.freeze, ["~> 3.1"])
  else
    s.add_dependency(%q<railties>.freeze, [">= 3.1"])
    s.add_dependency(%q<rails>.freeze, ["= 7.0.0.rc1"])
    s.add_dependency(%q<sprockets-rails>.freeze, ["~> 3.4"])
    s.add_dependency(%q<test-unit>.freeze, ["~> 3.1"])
  end
end
