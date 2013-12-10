require 'rubygems'
require 'bundler'
require 'jeweler'
require 'rake'
require 'rspec/core'
require 'rspec/core/rake_task'

begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts 'Run `bundle install` to install missing gems'
  exit e.status_code
end

Jeweler::Tasks.new do |gem|
  gem.name = 'cypher'
  gem.homepage = 'http://davidhuie.github.io/cypher'
  gem.license = 'MIT'
  gem.summary = 'A password management CLI tool'
  gem.description = 'A password management CLI tool'
  gem.email = 'dahuie@gmail.com'
  gem.authors = ['David Huie']
  gem.executables = ['cypher']
end

Jeweler::RubygemsDotOrgTasks.new

RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

task :default => :spec
