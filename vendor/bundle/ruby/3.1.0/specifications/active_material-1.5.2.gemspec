# -*- encoding: utf-8 -*-
# stub: active_material 1.5.2 ruby lib

Gem::Specification.new do |s|
  s.name = "active_material".freeze
  s.version = "1.5.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Nate Hunzaker".freeze, "David Eisinger".freeze]
  s.date = "2021-05-18"
  s.description = "ActiveAdmin skin based on Google's Material Design.".freeze
  s.email = ["nate.hunzaker@viget.com".freeze, "david.eisinger@viget.com".freeze]
  s.homepage = "".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.3.7".freeze
  s.summary = "ActiveAdmin skin based on Google's Material Design.".freeze

  s.installed_by_version = "3.3.7" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_development_dependency(%q<bundler>.freeze, ["~> 1.7"])
    s.add_development_dependency(%q<rake>.freeze, ["~> 10.0"])
    s.add_development_dependency(%q<sass-rails>.freeze, [">= 0"])
  else
    s.add_dependency(%q<bundler>.freeze, ["~> 1.7"])
    s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
    s.add_dependency(%q<sass-rails>.freeze, [">= 0"])
  end
end
