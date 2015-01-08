# i18n YAML Generator

[![Build Status](https://travis-ci.org/5minlab/i18n-yaml-generator.svg?branch=master)](https://travis-ci.org/5minlab/i18n-yaml-generator)


Generate locale yaml from i18n excel file.


## Install
```
gem install bundler
bundle install
```

## Usage
```bash
Usage: ./lib/i18n_yaml_generator.rb <i18n excel> <config yaml>
i18n excel : Internationalization Excel File (extension: xlsx)
config yaml : Configuration File (extension: yml)
```

### Sample
```bash
./lib/i18n_yaml_generator.rb data/sample-1.xlsx data/sample-1.yml
```


