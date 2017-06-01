module ActiveAdmin::SortableTree
  class Compatibility
    def self.normalized_resource_name(resource_name)
      if Rails::VERSION::MAJOR >= 5
        resource_name.to_s.underscore.parameterize(separator: "_".freeze)
      else
        resource_name.to_s.underscore.parameterize("_".freeze)
      end
    end
  end
end
