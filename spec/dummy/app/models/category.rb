class Category < ActiveRecord::Base
  has_ancestry
  attr_accessible :ancestry, :description, :name, :position
end
