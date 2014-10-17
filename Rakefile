#!/usr/bin/env rake
begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end
begin
  require 'rdoc/task'
rescue LoadError
  require 'rdoc/rdoc'
  require 'rake/rdoctask'
  RDoc::Task = Rake::RDocTask
end

ENV['RAILS_VERSION'] ||= '4.0'

RDoc::Task.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'ActiveAdmin::SortableTree'
  rdoc.options << '--line-numbers'
  rdoc.rdoc_files.include('README.rdoc')
  rdoc.rdoc_files.include('lib/**/*.rb')
end


Bundler::GemHelper.install_tasks

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)
task default: ['dummy:prepare', :spec]

require 'rake/clean'
CLEAN.include 'spec/dummy/db/*sqlite3', 'spec/dummy/log/*', 'spec/dummy/public/assets/*', 'spec/dummy/tmp/**/*'

namespace :dummy do
  desc 'Setup dummy app database'
  task :prepare do
    # File.expand_path is executed directory of generated Rails app
    rakefile = File.expand_path('Rakefile', dummy_path)
    command = "rake -f '%s' db:schema:load RAILS_ENV=test" % rakefile
    sh(command) unless ENV["DISABLE_CREATE"]
  end

  # task :migrate do
  #   # File.expand_path is executed directory of generated Rails app
  #   rakefile = File.expand_path('Rakefile', dummy_path)
  #   command = "rake -f '%s' db:migrate db:test:prepare" % rakefile
  #   sh(command) unless ENV["DISABLE_MIGRATE"]
  # end

  def dummy_path
    rel_path = ENV['DUMMY_APP_PATH'] || 'spec/dummy'
    if @current_path.to_s.include?(rel_path)
      @current_path
    else
      @current_path = File.expand_path(rel_path)
    end
  end
end
