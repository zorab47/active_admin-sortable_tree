class Category < ActiveRecord::Base
  has_ancestry
  attr_accessible :ancestry, :description, :name, :position if ENV['RAILS_VERSION'] == "3.2"
end
