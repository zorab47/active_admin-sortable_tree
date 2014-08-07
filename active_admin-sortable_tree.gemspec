$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "active_admin/sortable_tree/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "active_admin-sortable_tree"
  s.version     = ActiveAdmin::SortableTree::VERSION
  s.authors     = ["Francesco Disperati"]
  s.email       = ["me@nebirhos.com"]
  s.homepage    = "https://github.com/zorab47/active_admin-sortable_tree"
  s.summary     = "Show ActiveAdmin index as a nested tree, with drag'n'drop"
  s.description = "Show ActiveAdmin index as a nested tree, with drag'n'drop"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 3.2"
  s.add_dependency "activeadmin", ">= 0.6"
  s.add_dependency 'jquery-ui-rails', '~> 4.1.2'

  s.add_development_dependency 'capybara'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'phantomjs'
  s.add_development_dependency 'poltergeist'
  s.add_development_dependency 'database_cleaner'
end
