# -*- encoding: utf-8 -*-
# stub: activeadmin_quill_editor 1.3.0 ruby lib

Gem::Specification.new do |s|
  s.name = "activeadmin_quill_editor".freeze
  s.version = "1.3.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "changelog_uri" => "https://github.com/blocknotes/activeadmin_quill_editor/blob/main/CHANGELOG.md", "homepage_uri" => "https://github.com/blocknotes/activeadmin_quill_editor", "rubygems_mfa_required" => "true", "source_code_uri" => "https://github.com/blocknotes/activeadmin_quill_editor" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Mattia Roccoberton".freeze]
  s.date = "2025-03-18"
  s.description = "An Active Admin plugin to use Quill Rich Text Editor".freeze
  s.email = "mat@blocknot.es".freeze
  s.homepage = "https://github.com/blocknotes/activeadmin_quill_editor".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 3.0".freeze)
  s.rubygems_version = "3.3.7".freeze
  s.summary = "Quill Editor for ActiveAdmin".freeze

  s.installed_by_version = "3.3.7" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<activeadmin>.freeze, [">= 2.9", "< 4"])
    s.add_development_dependency(%q<appraisal>.freeze, ["~> 2.4"])
  else
    s.add_dependency(%q<activeadmin>.freeze, [">= 2.9", "< 4"])
    s.add_dependency(%q<appraisal>.freeze, ["~> 2.4"])
  end
end
