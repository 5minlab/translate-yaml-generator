#!/usr/bin/env ruby
# encoding: utf-8

require_relative "translate_yaml_generator/core"
require_relative "translate_yaml_generator/reader"
require_relative "translate_yaml_generator/writer"
require_relative "translate_yaml_generator/cli"

if __FILE__ == $0
  TranslateYamlGenerator::main
end
