ActiveAdmin.register Category do
  sortable

  permit_params :name, :ancestry, :description, :position if ENV['RAILS_VERSION'] == '4'

  index as: :sortable do
    label :name
    actions
  end

  form do |f|
    f.inputs :name, :description
    f.actions
  end
end
