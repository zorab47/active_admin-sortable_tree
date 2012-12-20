module ActiveAdmin
  module Tree
    class Engine < ::Rails::Engine
      engine_name 'activeadmin_tree'

      initializer "require models", group: :all do |app|
        # ActiveSupport.on_load(:active_record) do
        #   require 'active_admin/seo/meta'
        # end
      end

      initializer "Railsyard precompile hook" do |app|
        app.config.assets.precompile += [ "active_admin/tree.css",
                                          "active_admin/tree.js" ]
      end

      initializer "add assets" do
        ActiveAdmin.application.register_stylesheet "active_admin/tree.css"
        ActiveAdmin.application.register_javascript "active_admin/tree.js"
      end
    end
  end
end
