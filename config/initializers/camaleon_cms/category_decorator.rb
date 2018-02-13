Rails.application.config.to_prepare do
  CamaleonCms::CategoryDecorator.class_eval do
    def the_url(*args)
      args = args.extract_options!
      args[:post_type] = object.post_type.slug
      args[:category_slug] = the_slug
      args[:locale] = @_deco_locale unless args.include?(:locale)
      args[:format] = args[:format] || "html"
      as_path = args.delete(:as_path)
      h.cama_url_to_fixed("cama_category_hierarchy_#{as_path.present? ? "path" : "url"}", args)
    end
  end
end