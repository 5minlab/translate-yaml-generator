# Translate YAML Generator

[![Build Status](https://travis-ci.org/5minlab/translate-yaml-generator.svg?branch=master)](https://travis-ci.org/5minlab/translate-yaml-generator)


Generate translation yaml from excel file. (for L10N, I18N)

## Feature
* Manage translation via MS Excel file.
* Generate YAML Locale file from Excel file.

## Install
```
gem install bundler
bundle install
```

## Usage
```bash
Usage: ./lib/translate_yaml_generator.rb <translate data excel> <config yaml>
i18n excel : Excel File for Translate Data (extension: xlsx)
config yaml : Configuration File (extension: yml)
```

### Sample
```bash
./lib/translate_yaml_generator.rb data/sample-1.xlsx data/sample-1.yml
```


