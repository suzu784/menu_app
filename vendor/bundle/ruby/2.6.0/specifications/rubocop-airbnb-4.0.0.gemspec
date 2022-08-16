# -*- encoding: utf-8 -*-
# stub: rubocop-airbnb 4.0.0 ruby lib

Gem::Specification.new do |s|
  s.name = "rubocop-airbnb".freeze
  s.version = "4.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Airbnb Engineering".freeze]
  s.date = "2021-09-21"
  s.description = "    A plugin for RuboCop code style enforcing & linting tool. It includes Rubocop configuration\n    used at Airbnb and a few custom rules that have cause internal issues at Airbnb but are not\n    supported by core Rubocop.\n".freeze
  s.email = ["rubocop@airbnb.com".freeze]
  s.homepage = "https://github.com/airbnb/ruby".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.4".freeze)
  s.rubygems_version = "3.0.8".freeze
  s.summary = "Custom code style checking for Airbnb.".freeze

  s.installed_by_version = "3.0.8" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rubocop>.freeze, ["~> 0.93.1"])
      s.add_runtime_dependency(%q<rubocop-performance>.freeze, ["~> 1.10.2"])
      s.add_runtime_dependency(%q<rubocop-rails>.freeze, ["~> 2.9.1"])
      s.add_runtime_dependency(%q<rubocop-rspec>.freeze, ["~> 1.44.1"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 3.5"])
    else
      s.add_dependency(%q<rubocop>.freeze, ["~> 0.93.1"])
      s.add_dependency(%q<rubocop-performance>.freeze, ["~> 1.10.2"])
      s.add_dependency(%q<rubocop-rails>.freeze, ["~> 2.9.1"])
      s.add_dependency(%q<rubocop-rspec>.freeze, ["~> 1.44.1"])
      s.add_dependency(%q<rspec>.freeze, ["~> 3.5"])
    end
  else
    s.add_dependency(%q<rubocop>.freeze, ["~> 0.93.1"])
    s.add_dependency(%q<rubocop-performance>.freeze, ["~> 1.10.2"])
    s.add_dependency(%q<rubocop-rails>.freeze, ["~> 2.9.1"])
    s.add_dependency(%q<rubocop-rspec>.freeze, ["~> 1.44.1"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.5"])
  end
end
