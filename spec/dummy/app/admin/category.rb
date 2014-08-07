ActiveAdmin.register Category do
  sortable

  index as: :sortable do
    label :name
    actions
  end
end
