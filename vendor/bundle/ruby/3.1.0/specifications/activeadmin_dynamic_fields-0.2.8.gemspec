# -*- encoding: utf-8 -*-
# stub: activeadmin_dynamic_fields 0.2.8 ruby lib

Gem::Specification.new do |s|
  s.name = "activeadmin_dynamic_fields".freeze
  s.version = "0.2.8"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Mattia Roccoberton".freeze]
  s.date = "2020-08-28"
  s.description = "An Active Admin plugin to add dynamic behaviors to fields".freeze
  s.email = "mat@blocknot.es".freeze
  s.homepage = "https://github.com/blocknotes/activeadmin_dynamic_fields".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.3.7".freeze
  s.summary = "Dynamic fields for ActiveAdmin".freeze

  s.installed_by_version = "3.3.7" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<activeadmin>.freeze, ["~> 2.0"])
    s.add_development_dependency(%q<activestorage>.freeze, ["~> 6.0.3.2"])
    s.add_development_dependency(%q<capybara>.freeze, ["~> 3.33.0"])
    s.add_development_dependency(%q<pry>.freeze, ["~> 0.13.1"])
    s.add_development_dependency(%q<puma>.freeze, ["~> 4.3.5"])
    s.add_development_dependency(%q<rspec_junit_formatter>.freeze, ["~> 0.4.1"])
    s.add_development_dependency(%q<rspec-rails>.freeze, ["~> 4.0.1"])
    s.add_development_dependency(%q<selenium-webdriver>.freeze, ["~> 3.142.7"])
    s.add_development_dependency(%q<simplecov>.freeze, ["~> 0.19.0"])
    s.add_development_dependency(%q<sqlite3>.freeze, ["~> 1.4.2"])
  else
    s.add_dependency(%q<activeadmin>.freeze, ["~> 2.0"])
    s.add_dependency(%q<activestorage>.freeze, ["~> 6.0.3.2"])
    s.add_dependency(%q<capybara>.freeze, ["~> 3.33.0"])
    s.add_dependency(%q<pry>.freeze, ["~> 0.13.1"])
    s.add_dependency(%q<puma>.freeze, ["~> 4.3.5"])
    s.add_dependency(%q<rspec_junit_formatter>.freeze, ["~> 0.4.1"])
    s.add_dependency(%q<rspec-rails>.freeze, ["~> 4.0.1"])
    s.add_dependency(%q<selenium-webdriver>.freeze, ["~> 3.142.7"])
    s.add_dependency(%q<simplecov>.freeze, ["~> 0.19.0"])
    s.add_dependency(%q<sqlite3>.freeze, ["~> 1.4.2"])
  end
end
