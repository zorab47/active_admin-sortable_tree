module ActiveAdmin
  module Views
    IndexAsBlock.class_eval do

      def build(page_presenter, collection)
        add_class "index"
        if active_admin_config.dsl.sortable_options
          set_attribute "data-sortable-type", "plain"

          sort_url = if (( sort_url_block = active_admin_config.dsl.sortable_options[:sort_url] ))
                       sort_url_block.call(self)
                     else
                       url_for(:action => :sort)
                     end

          set_attribute "data-sortable-url", sort_url
          collection.sort_by! do |a|
            a.send(active_admin_config.dsl.sortable_options[:sorting_attribute]) || 1
          end
        end
        resource_selection_toggle_panel if active_admin_config.batch_actions.any?
        collection.each do |obj|
          instance_exec(obj, &page_presenter.block)
        end
      end

    end
  end
end

