$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "active_admin/sortable/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "activeadmin-sortable-tree"
  s.version     = ActiveAdmin::Sortable::VERSION
  s.authors     = ["Francesco Disperati"]
  s.email       = ["nebirhos@aol.com"]
  s.homepage    = "https://github.com/nebirhos/activeadmin-sortable-tree"
  s.summary     = "Show ActiveAdmin index as a nested tree, with drag'n'drop"
  s.description = "TODO: Description of ActiveadminTree."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 3.2.9"
  # s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
end
