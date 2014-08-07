ActiveAdmin.register Category, as: "CategoryTree" do
  sortable tree: true

  index as: :sortable do
    label :name
    actions
  end
end
