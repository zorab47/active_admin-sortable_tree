class Category < ActiveRecord::Base
  has_ancestry
  attr_accessible :ancestry, :description, :name, :position if Float(ENV['RAILS_VERSION']) < 4
end
