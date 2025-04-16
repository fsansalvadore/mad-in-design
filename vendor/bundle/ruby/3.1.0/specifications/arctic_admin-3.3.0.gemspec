# -*- encoding: utf-8 -*-
# stub: arctic_admin 3.3.0 ruby lib

Gem::Specification.new do |s|
  s.name = "arctic_admin".freeze
  s.version = "3.3.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Cl\u00E9ment Prod'homme".freeze]
  s.date = "2020-12-07"
  s.description = "A responsive theme for Active Admin".freeze
  s.homepage = "https://github.com/cprodhomme/arctic_admin".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.3.7".freeze
  s.summary = "Arctic Admin theme for ActiveAdmin".freeze

  s.installed_by_version = "3.3.7" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_development_dependency(%q<bundler>.freeze, ["~> 1.5"])
    s.add_development_dependency(%q<rake>.freeze, [">= 0"])
    s.add_runtime_dependency(%q<activeadmin>.freeze, [">= 1.1.0", "< 3.0"])
    s.add_runtime_dependency(%q<jquery-rails>.freeze, [">= 0"])
    s.add_runtime_dependency(%q<font-awesome-sass>.freeze, ["~> 5.0"])
  else
    s.add_dependency(%q<bundler>.freeze, ["~> 1.5"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<activeadmin>.freeze, [">= 1.1.0", "< 3.0"])
    s.add_dependency(%q<jquery-rails>.freeze, [">= 0"])
    s.add_dependency(%q<font-awesome-sass>.freeze, ["~> 5.0"])
  end
end
