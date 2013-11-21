module ActiveAdmin
  module Views

    # = Index as a Sortable List or Tree
    class IndexAsSortable < ActiveAdmin::Component
      def build(page_presenter, collection)
        @page_presenter = page_presenter
        @collection = if tree?
                        roots
                      else
                        collection
                      end
        @collection.sort_by! do |a|
          a.send(options[:sorting_attribute]) || 1
        end
        @resource_name = active_admin_config.resource_name.to_s.underscore.parameterize('_')

        # Call the block passed in. This will set the
        # title and body methods
        instance_eval &page_presenter.block if page_presenter.block

        add_class "index"
        build_list
      end

      def self.index_name; "sortable"; end

      def options
        active_admin_config.dsl.sortable_options
      end

      def roots
        roots_collection || default_roots_collection
      end

      # Find the roots by calling the roots method directly on the resource.
      # This effectively performs:
      #
      #     TreeNode.roots # => [#<TreeNode id:1>, ... ]
      #
      # Returns collection of roots.
      def default_roots_collection
        resource_class.send(options[:roots_method])
      end

      # Use user-defined logic to find the root nodes. This executes a callable
      # object within the context of the resource's controller.
      #
      # Example
      #
      #     options[:roots_collection] = proc { current_user.tree_nodes.roots }
      #
      # Returns collection of roots.
      def roots_collection
        if (callable = options[:roots_collection])
          controller.instance_exec(&callable)
        end
      end

      def tree?
        !!options[:tree]
      end

      # Setter method for the configuration of the label
      def label(method = nil, &block)
        if block_given? || method
          @label = block_given? ? block : method
        end
        @label
      end

      # Adds links to View, Edit and Delete
      def actions(options = {}, &block)
        options = { :defaults => true }.merge(options)
        @default_actions = options[:defaults]
        @other_actions = block
      end


      protected

      def build_list
        resource_selection_toggle_panel if active_admin_config.batch_actions.any?
        sort_url = if (( sort_url_block = options[:sort_url] ))
                     sort_url_block.call(self)
                   else
                     url_for(:action => :sort)
                   end
        data_options = {
          "data-sortable-type" => (tree? ? "tree" : "list"),
          "data-sortable-url" => sort_url,
        }
        data_options["data-max-levels"] = options[:max_levels]
        data_options["data-start-collapsed"] = options[:start_collapsed]
        data_options["data-protect-root"] = true if options[:protect_root]

        ol data_options do
          @collection.each do |item|
            build_nested_item(item)
          end
        end
      end

      def build_nested_item(item)
        li :id => "#{@resource_name}_#{item.id}" do

          div :class => "item " << cycle("odd", "even", :name => "list_class") do
            div :class => "cell left" do
              resource_selection_cell(item) if active_admin_config.batch_actions.any?
            end

            span :class => :disclose do
              span
            end if options[:collapsible]

            h3 :class => "cell left" do
              call_method_or_proc_on(item, @label)
            end
            div :class => "cell right" do
              build_actions(item)
            end
          end

          ol do
            item.send(options[:children_method]).order(options[:sorting_attribute]).each do |c|
              build_nested_item(c)
            end
          end if tree?
        end
      end

      def build_actions(resource)
        links = ''.html_safe
        if @default_actions
          if controller.action_methods.include?('show')
            links << link_to(I18n.t('active_admin.view'), resource_path(resource), :class => "member_link view_link")
          end
          if controller.action_methods.include?('edit')
            links << link_to(I18n.t('active_admin.edit'), edit_resource_path(resource), :class => "member_link edit_link")
          end
          if controller.action_methods.include?('destroy')
            links << link_to(I18n.t('active_admin.delete'), resource_path(resource), :method => :delete, :data => {:confirm => I18n.t('active_admin.delete_confirmation')}, :class => "member_link delete_link")
          end
        end
        links << instance_exec(resource, &@other_actions) if @other_actions
        links
      end

    end
  end
end

