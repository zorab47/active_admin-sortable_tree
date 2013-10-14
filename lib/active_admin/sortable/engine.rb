require 'activeadmin'

module ActiveAdmin
  module Sortable
    class Engine < ::Rails::Engine
      engine_name 'activeadmin_sortable_tree'

      initializer "Rails precompile hook", group: :all do |app|
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
