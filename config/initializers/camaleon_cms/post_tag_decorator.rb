Rails.application.config.to_prepare do
  CamaleonCms::PostTagDecorator.class_eval do
    def the_url(*args)
      args = args.extract_options!
      args[:label] = 'tag'
      args[:post_tag_slug] = the_slug
      args[:locale] = get_locale unless args.include?(:locale)
      args[:format] = args[:format] || "html"
      as_path = args.delete(:as_path)
      h.cama_url_to_fixed("cama_post_tag_s_#{as_path.present? ? "path" : "url"}", args)
    end
  end
end