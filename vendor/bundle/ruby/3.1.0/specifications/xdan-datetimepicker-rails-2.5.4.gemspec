# -*- encoding: utf-8 -*-
# stub: xdan-datetimepicker-rails 2.5.4 ruby lib

Gem::Specification.new do |s|
  s.name = "xdan-datetimepicker-rails".freeze
  s.version = "2.5.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Joshua Kovach".freeze]
  s.date = "2016-05-22"
  s.description = "XDan's jQuery DateTimePicker packaged for the Rails Asset Pipeline".freeze
  s.email = ["kovach.jc@gmail.com".freeze]
  s.homepage = "https://www.github.com/shekibobo/xdan-datetimepicker-rails".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.3.7".freeze
  s.summary = "XDan's jQuery DateTimePicker packaged for the Rails Asset Pipeline".freeze

  s.installed_by_version = "3.3.7" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<rails>.freeze, [">= 3.2.16"])
    s.add_runtime_dependency(%q<jquery-rails>.freeze, [">= 0"])
    s.add_development_dependency(%q<bundler>.freeze, ["~> 1.5"])
    s.add_development_dependency(%q<rake>.freeze, [">= 0"])
  else
    s.add_dependency(%q<rails>.freeze, [">= 3.2.16"])
    s.add_dependency(%q<jquery-rails>.freeze, [">= 0"])
    s.add_dependency(%q<bundler>.freeze, ["~> 1.5"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
  end
end
