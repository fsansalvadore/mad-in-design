# -*- encoding: utf-8 -*-
# stub: uglifier 4.2.1 ruby lib

Gem::Specification.new do |s|
  s.name = "uglifier".freeze
  s.version = "4.2.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Ville Lautanala".freeze]
  s.date = "2024-09-22"
  s.description = "Uglifier minifies JavaScript files by wrapping UglifyJS to be accessible in Ruby".freeze
  s.email = ["lautis@gmail.com".freeze]
  s.extra_rdoc_files = ["LICENSE.txt".freeze, "README.md".freeze, "CHANGELOG.md".freeze, "CONTRIBUTING.md".freeze]
  s.files = ["CHANGELOG.md".freeze, "CONTRIBUTING.md".freeze, "LICENSE.txt".freeze, "README.md".freeze]
  s.homepage = "https://github.com/lautis/uglifier".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.4.0".freeze)
  s.rubygems_version = "3.3.7".freeze
  s.summary = "Ruby wrapper for UglifyJS JavaScript compressor".freeze

  s.installed_by_version = "3.3.7" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<execjs>.freeze, [">= 0.3.0", "< 3"])
    s.add_development_dependency(%q<rspec>.freeze, ["~> 3.0"])
    s.add_development_dependency(%q<rake>.freeze, ["~> 12.0"])
    s.add_development_dependency(%q<bundler>.freeze, [">= 1.3"])
    s.add_development_dependency(%q<sourcemap>.freeze, ["~> 0.1.1"])
  else
    s.add_dependency(%q<execjs>.freeze, [">= 0.3.0", "< 3"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.0"])
    s.add_dependency(%q<rake>.freeze, ["~> 12.0"])
    s.add_dependency(%q<bundler>.freeze, [">= 1.3"])
    s.add_dependency(%q<sourcemap>.freeze, ["~> 0.1.1"])
  end
end
