# encoding: utf-8

require "yaml"
require "fileutils"

module TranslateYamlGenerator
  def self.run(data_filename, config_filename)
    config_content = File.read config_filename
    config = YAML.load(config_content)

    reader = TranslateYamlGenerator::Reader::XlsxReader.new
    root = reader.read data_filename

    base_dir = File.dirname(data_filename)

    config["languages"].each_with_index do |data, idx|
      writer = TranslateYamlGenerator::Writer::YamlWriter.new
      writer.locale = data["lang"]
      writer.locale_idx = idx

      filename = data["file"]
      if filename[0] == '/'
        target_dir = File.dirname(filename)
      else
        target_dir = File.join(base_dir, File.dirname(filename))
      end
      FileUtils::mkdir_p target_dir

      File.open(File.join(base_dir, filename), 'w') do |f|
        f.write(writer.write root)
      end
    end
  end

  def self.main
    if ARGV.length == 2
      data_filename = ARGV[0]
      config_filename = ARGV[1]
      run data_filename, config_filename
    else
      puts <<eos
Usage: #{$0} <translate excel> <config yaml>
translate excel : Internationalization Excel File (extension: xlsx)
config yaml : Configuration File (extension: yml)
eos
    end
  end
end
