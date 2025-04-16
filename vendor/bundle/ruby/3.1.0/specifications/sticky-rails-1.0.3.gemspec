# -*- encoding: utf-8 -*-
# stub: sticky-rails 1.0.3 ruby lib

Gem::Specification.new do |s|
  s.name = "sticky-rails".freeze
  s.version = "1.0.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["navinspm".freeze]
  s.date = "2015-12-09"
  s.description = "".freeze
  s.email = ["navinspm@gmail.com".freeze]
  s.homepage = "https://github.com/navinspm/sticky-rails".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.3.7".freeze
  s.summary = "Sticky( http://stickyjs.com ) is a jQuery plugin that gives you the ability to make any element on your page always stay visible .This is gemmified version of sticky".freeze

  s.installed_by_version = "3.3.7" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_development_dependency(%q<bundler>.freeze, ["~> 1.6"])
    s.add_development_dependency(%q<rake>.freeze, [">= 0"])
  else
    s.add_dependency(%q<bundler>.freeze, ["~> 1.6"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
  end
end
