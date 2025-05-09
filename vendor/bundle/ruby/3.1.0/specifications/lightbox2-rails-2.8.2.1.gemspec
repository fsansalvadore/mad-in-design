# -*- encoding: utf-8 -*-
# stub: lightbox2-rails 2.8.2.1 ruby lib

Gem::Specification.new do |s|
  s.name = "lightbox2-rails".freeze
  s.version = "2.8.2.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Gavin Lam".freeze]
  s.date = "2016-03-30"
  s.description = "Lightbox2 for Rails asset pipeline".freeze
  s.email = ["me@gavin.hk".freeze]
  s.homepage = "https://github.com/gavinkflam/lightbox2-rails".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.3.7".freeze
  s.summary = "Lightbox2 for Rails asset pipeline".freeze

  s.installed_by_version = "3.3.7" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<railties>.freeze, [">= 3.1"])
  else
    s.add_dependency(%q<railties>.freeze, [">= 3.1"])
  end
end
