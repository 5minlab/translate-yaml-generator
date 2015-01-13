# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://guides.rubygems.org/specification-reference/ for more options
  gem.name = "translate-yaml-generator"
  gem.homepage = "http://github.com/5minlab/translate-yaml-generator"
  gem.license = "MIT"
  gem.summary = %Q{Generate translation yaml from excel file. (for L10N, I18N)}
  gem.description = %Q{Generate translation yaml from excel file. (for L10N, I18N)}
  gem.email = "libsora25@gmail.com"
  gem.authors = ["if1live"]
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

require "rspec/core/rake_task"
RSpec::Core::RakeTask.new(:spec)
task :test => :spec

desc "Code coverage detail"
task :simplecov do
  ENV['COVERAGE'] = "true"
  Rake::Task['test'].execute
end

task :default => :test

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "translate-yaml-generator #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
