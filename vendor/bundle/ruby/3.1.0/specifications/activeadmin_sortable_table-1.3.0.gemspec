# -*- encoding: utf-8 -*-
# stub: activeadmin_sortable_table 1.3.0 ruby lib

Gem::Specification.new do |s|
  s.name = "activeadmin_sortable_table".freeze
  s.version = "1.3.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Adam McCrea".freeze, "Jonathan Gertig".freeze, "Artyom Bolshakov".freeze]
  s.date = "2018-08-21"
  s.description = "Drag and drop reordering interface for ActiveAdmin tables".freeze
  s.email = ["adam@adamlogic.com".freeze, "jcgertig@gmail.com".freeze, "abolshakov@spbtv.com".freeze]
  s.homepage = "https://github.com/bolshakov/activeadmin_sortable_table".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.3.7".freeze
  s.summary = "Drag and drop reordering interface for ActiveAdmin tables".freeze

  s.installed_by_version = "3.3.7" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<activeadmin>.freeze, [">= 1.0.0.pre1"])
    s.add_runtime_dependency(%q<uber>.freeze, ["= 0.0.15"])
    s.add_development_dependency(%q<rails>.freeze, ["~> 4.2"])
    s.add_development_dependency(%q<capybara>.freeze, [">= 0"])
    s.add_development_dependency(%q<rspec-rails>.freeze, ["~> 3.3"])
    s.add_development_dependency(%q<phantomjs>.freeze, [">= 0"])
    s.add_development_dependency(%q<poltergeist>.freeze, [">= 0"])
    s.add_development_dependency(%q<database_cleaner>.freeze, [">= 0"])
    s.add_development_dependency(%q<launchy>.freeze, [">= 0"])
  else
    s.add_dependency(%q<activeadmin>.freeze, [">= 1.0.0.pre1"])
    s.add_dependency(%q<uber>.freeze, ["= 0.0.15"])
    s.add_dependency(%q<rails>.freeze, ["~> 4.2"])
    s.add_dependency(%q<capybara>.freeze, [">= 0"])
    s.add_dependency(%q<rspec-rails>.freeze, ["~> 3.3"])
    s.add_dependency(%q<phantomjs>.freeze, [">= 0"])
    s.add_dependency(%q<poltergeist>.freeze, [">= 0"])
    s.add_dependency(%q<database_cleaner>.freeze, [">= 0"])
    s.add_dependency(%q<launchy>.freeze, [">= 0"])
  end
end
