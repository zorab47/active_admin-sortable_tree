$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "active_admin/sortable/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "activeadmin-sortable-tree"
  s.version     = ActiveAdmin::Sortable::VERSION
  s.authors     = ["Francesco Disperati"]
  s.email       = ["me@nebirhos.com"]
  s.homepage    = "https://github.com/nebirhos/activeadmin-sortable-tree"
  s.summary     = "Show ActiveAdmin index as a nested tree, with drag'n'drop"
  s.description = "Show ActiveAdmin index as a nested tree, with drag'n'drop"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", ">= 3.2"
  s.add_dependency "activeadmin"
  s.add_dependency "jquery-ui-rails", "~> 5.0"

  s.add_development_dependency "sqlite3"
end
