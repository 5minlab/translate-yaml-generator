# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-
# stub: translate-yaml-generator 0.0.1 ruby lib

Gem::Specification.new do |s|
  s.name = "translate-yaml-generator"
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["if1live"]
  s.date = "2015-01-13"
  s.description = "Generate translation yaml from excel file. (for L10N, I18N)"
  s.email = "libsora25@gmail.com"
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = [
    ".travis.yml",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "data/sample-1.xlsx",
    "data/sample-1.yml",
    "lib/translate_yaml_generator.rb",
    "lib/translate_yaml_generator/cli.rb",
    "lib/translate_yaml_generator/core.rb",
    "lib/translate_yaml_generator/reader.rb",
    "lib/translate_yaml_generator/writer.rb",
    "spec/lib/translate_yaml_generator/core_spec.rb",
    "spec/lib/translate_yaml_generator/reader_spec.rb",
    "spec/lib/translate_yaml_generator/writer_spec.rb"
  ]
  s.homepage = "http://github.com/5minlab/translate-yaml-generator"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.2.2"
  s.summary = "Generate translation yaml from excel file. (for L10N, I18N)"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rubyXL>, [">= 3.3.2"])
      s.add_development_dependency(%q<rdoc>, ["~> 3.12"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 2.0.1"])
      s.add_development_dependency(%q<rake>, ["~> 0.9.2"])
      s.add_development_dependency(%q<rspec>, ["~> 2.13"])
    else
      s.add_dependency(%q<rubyXL>, [">= 3.3.2"])
      s.add_dependency(%q<rdoc>, ["~> 3.12"])
      s.add_dependency(%q<bundler>, ["~> 1.0"])
      s.add_dependency(%q<jeweler>, ["~> 2.0.1"])
      s.add_dependency(%q<rake>, ["~> 0.9.2"])
      s.add_dependency(%q<rspec>, ["~> 2.13"])
    end
  else
    s.add_dependency(%q<rubyXL>, [">= 3.3.2"])
    s.add_dependency(%q<rdoc>, ["~> 3.12"])
    s.add_dependency(%q<bundler>, ["~> 1.0"])
    s.add_dependency(%q<jeweler>, ["~> 2.0.1"])
    s.add_dependency(%q<rake>, ["~> 0.9.2"])
    s.add_dependency(%q<rspec>, ["~> 2.13"])
  end
end

