module ActiveAdmin
  module Sortable
    class Engine < ::Rails::Engine
      engine_name 'activeadmin_tree'

      initializer "Railsyard precompile hook", group: :assets do |app|
        app.config.assets.precompile += [ "active_admin/sortable.css",
                                          "active_admin/sortable.js" ]
      end

      initializer "add assets" do
        ActiveAdmin.application.register_stylesheet "active_admin/sortable.css"
        ActiveAdmin.application.register_javascript "active_admin/sortable.js"
      end
    end
  end
end
