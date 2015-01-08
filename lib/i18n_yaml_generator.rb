# encoding: utf-8

require_relative "i18n_yaml_generator/core"
require_relative "i18n_yaml_generator/reader"
require_relative "i18n_yaml_generator/writer"
require_relative "i18n_yaml_generator/cli"

if __FILE__ == $0
  I18nYamlGenerator::main
end
