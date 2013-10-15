module ActiveAdmin::Sortable
  module ControllerActions

    attr_accessor :sortable_options

    def sortable(options = {})
      options.reverse_merge! :sorting_attribute => :position,
                             :parent_method => :parent,
                             :children_method => :children,
                             :roots_method => :roots,
                             :tree => false,
                             :max_levels => 0,
                             :protect_root => false,
                             :collapsible => false, #hides +/- buttons
                             :start_collapsed => false

      # BAD BAD BAD FIXME: don't pollute original class
      @sortable_options = options

      # disable pagination
      config.paginate = false

      collection_action :sort, :method => :post do
        resource_name = active_admin_config.resource_name.to_s.underscore.parameterize('_')

        records = params[resource_name].inject({}) do |res, (resource, parent_resource)|
          res[resource_class.find(resource)] = resource_class.find(parent_resource) rescue nil
          res
        end
        errors = []
        ActiveRecord::Base.transaction do
          records.each_with_index do |(record, parent_record), position|
            record.send "#{options[:sorting_attribute]}=", position
            if options[:tree]
              record.send "#{options[:parent_method]}=", parent_record
            end
            errors << {record.id => record.errors} if !record.save
          end
        end
        if errors.empty?
          head 200
        else
          render json: errors, status: 422
        end
      end

    end

  end

  ::ActiveAdmin::ResourceDSL.send(:include, ControllerActions)
end
