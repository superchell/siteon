Rails.application.config.to_prepare do
  CamaleonCms::PostDecorator.class_eval do

    # return front url for this post
    # sample: http://localhost.com/my-page.html
    # args:
    #   locale: language (default current language)
    #   as_path: return the path instead of full url, sample: /my-page.html
    #   Also, you can pass extra attributes as params for the url, sample: page.the_url(my_param: 'value', other: "asd")
    #     => http://localhost.com/my-page.html?my_param=value&other=asd
    # Return String URL
    def the_url(*args)
      args = args.extract_options!
      args[:locale] = get_locale unless args.include?(:locale)
      args[:format] = args[:format] || "html"
      args[:slug] = the_slug(args[:locale])
      p = args.delete(:as_path).present? ? "path" : "url"
      l = _calc_locale(args[:locale])
      ptype = object.post_type.decorate
      p_url_format = ptype.contents_route_format
      p_url_format = "hierarchy_post" if ptype.manage_hierarchy?
      case p_url_format
        when "post_of_post_type"
          args[:label] = I18n.t('routes.group', default: 'group')
          args[:post_type_id] = ptype.id
          args[:title] = ptype.the_title(args[:locale]).parameterize.presence || ptype.the_slug
        when "post_of_category"
          if ptype.manage_categories?
            cat = object.categories.first.decorate rescue ptype.default_category.decorate
            args[:label_cat] = I18n.t("routes.category", default: "category")
            args[:category_id] = cat.id
            args[:title] = cat.the_title(args[:locale]).parameterize
            args[:title] = cat.the_slug unless args[:title].present?
          else
            p_url_format = "post"
          end
        when "post_of_posttype"
          args[:post_type_title] = ptype.the_title(args[:locale]).parameterize.presence || ptype.the_slug
        when "post_of_category_post_type"
          if ptype.manage_categories?
            cat = object.categories.first.decorate rescue ptype.default_category.decorate
            args[:label_cat] = I18n.t("routes.category", default: "category")
            args[:post_type_title] = ptype.the_title(args[:locale]).parameterize.presence || ptype.the_slug
            args[:category_id] = cat.id
            args[:title] = cat.the_title(args[:locale]).parameterize
            args[:title] = cat.the_slug unless args[:title].present?
          else
            p_url_format = "post"
          end
        when 'full_hierarchy_post'
          if ptype.manage_categories?
            cat = object.categories.first.decorate rescue ptype.default_category.decorate
            args[:post_type] = ptype.the_slug
            args[:category_slug] = cat.the_slug
          else
            p_url_format = "post"
          end
        when 'hierarchy_post'
          if object.post_parent.present?
            slugs = ([args[:slug]]+object.parents.map{|parent| parent.decorate.the_slug(args[:locale]) }).reverse
            args[:slug], args[:parent_title] = slugs.slice(1..-1).join("/"), slugs.first
          else
            p_url_format = "post"
          end
      end
      h.cama_url_to_fixed("cama_#{p_url_format}_#{p}", args)
    end

  end
end