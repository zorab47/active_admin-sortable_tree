ActiveAdmin.register Category do
  sortable

  permit_params :name, :ancestry, :description, :position if Float(ENV['RAILS_VERSION']) >= 4.0

  index as: :sortable do
    label :name
    actions
  end

  form do |f|
    f.inputs :name, :description
    f.actions
  end
end
