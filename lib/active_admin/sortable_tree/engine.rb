require "activeadmin"

module ActiveAdmin
  module SortableTree
    class Engine < ::Rails::Engine
      engine_name "active_admin-sortable_tree"

      initializer "active_admin-sortable_tree.precompile", group: :all do |app|
        app.config.assets.precompile += [
          "active_admin/sortable.css",
          "active_admin/sortable.js"
        ]
      end

      initializer "active_admin-sortable_tree.register_assets" do
        ActiveAdmin.application.register_stylesheet "active_admin/sortable.css"
        ActiveAdmin.application.register_javascript "active_admin/sortable.js"
      end
    end
  end
end
