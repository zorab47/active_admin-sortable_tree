ActiveAdmin.register Category, as: "CategoryTree" do
  sortable tree: true
  actions :index

  index as: :sortable do
    label :name
    actions
  end
end
