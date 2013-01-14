module ActiveAdmin::Sortable
  module ControllerActions

    attr_accessor :sortable_options

    def sortable(options = {})
      options.reverse_merge! :sorting_attribute => :position,
                             :parent_method => :parent,
                             :children_method => :children,
                             :roots_method => :roots,
                             :tree => false

      # BAD BAD BAD FIXME: don't pollute original class
      @sortable_options = options

      collection_action :sort, :method => :post do
        resource_name = resource_class.name.underscore.parameterize('_')

        records = params[resource_name].inject({}) do |res, (resource, parent_resource)|
          res[resource_class.find(resource)] = resource_class.find(parent_resource) rescue nil
          res
        end
        records.each_with_index do |(record, parent_record), position|
          record.send "#{options[:sorting_attribute]}=", position
          if options[:tree]
            record.send "#{options[:parent_method]}=", parent_record
          end
          record.save!
        end
        head 200
      end

    end

  end

  ::ActiveAdmin::ResourceDSL.send(:include, ControllerActions)
end
