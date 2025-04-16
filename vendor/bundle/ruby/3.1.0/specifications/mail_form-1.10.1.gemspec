# -*- encoding: utf-8 -*-
# stub: mail_form 1.10.1 ruby lib

Gem::Specification.new do |s|
  s.name = "mail_form".freeze
  s.version = "1.10.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "bug_tracker_uri" => "https://github.com/heartcombo/mail_form/issues", "changelog_uri" => "https://github.com/heartcombo/mail_form/blob/main/CHANGELOG.md", "homepage_uri" => "https://github.com/heartcombo/mail_form", "source_code_uri" => "https://github.com/heartcombo/mail_form", "wiki_uri" => "https://github.com/heartcombo/mail_form/wiki" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Jos\u00E9 Valim".freeze, "Carlos Ant\u00F4nio".freeze]
  s.date = "2023-10-11"
  s.description = "Send e-mail straight from forms in Rails with I18n, validations, attachments and request information.".freeze
  s.email = "contact@plataformatec.com.br".freeze
  s.homepage = "https://github.com/plataformatec/mail_form".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.5.0".freeze)
  s.rubygems_version = "3.3.7".freeze
  s.summary = "Send e-mail straight from forms in Rails with I18n, validations, attachments and request information.".freeze

  s.installed_by_version = "3.3.7" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<actionmailer>.freeze, [">= 5.2"])
    s.add_runtime_dependency(%q<activemodel>.freeze, [">= 5.2"])
  else
    s.add_dependency(%q<actionmailer>.freeze, [">= 5.2"])
    s.add_dependency(%q<activemodel>.freeze, [">= 5.2"])
  end
end
