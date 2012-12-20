$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "active_admin/tree/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "activeadmin-tree"
  s.version     = ActiveAdmin::Tree::VERSION
  s.authors     = ["Francesco Disperati"]
  s.email       = ["nebirhos@aol.com"]
  s.homepage    = "https://github.com/nebirhos/activeadmin-tree"
  s.summary     = "TODO: Summary of ActiveadminTree."
  s.description = "TODO: Description of ActiveadminTree."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 3.2.9"
  # s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
end
