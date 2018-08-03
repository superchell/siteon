module CamaleonCms::Frontend::CustomHelper

  def get_background_image(url)
    r = ''
    if url.present?
      r = "background-image: url(#{url});"
    end
    r
  end

  def get_background_color(color)
    r = ''
    if color.present?
      r = "background-color: #{color};"
    end
    r
  end

  def theme_img_url (path)
    asset_url theme_asset_path "images/#{path}"
  end

  def get_form_field (form, id)
    r = nil
    fields = JSON.parse(form.value).to_sym.values.first
    fields.each do |field|
      if field[:cid] == id
        r = field
        r[:name] = "fields[#{r[:cid]}]"
      end
    end
    r
  end

  def empty_field_group?(group)
    group.first.values.each do |v|
      return false if v.present?
    end
    true
  end

  def filtered_breadcrumbs
    if @post_type.slug == 'page' && !@post.nil?
      raw "<li class='active'>#{@post.the_title}</li>"
    elsif !@post.nil?
      raw @post.the_breadcrumb
    elsif !@category.nil?
      raw @category.the_breadcrumb
    else
      raw @post_type.the_breadcrumb
    end
  end

  def siteon_pagination(items, *will_paginate_options)
    will_paginate_options = will_paginate_options.extract_options!
    will_paginate_options[:previous_label] = '<i class="ion-ios-arrow-left"></i>'
    will_paginate_options[:next_label] = '<i class="ion-ios-arrow-right"></i>'
    "<div class=\"container\">
      <div class=\"row iq-mt-80\">
        <div class=\"col-lg-12 col-md-12 text-center\">
          <ul class=\"pagination pagination-lg\">
            #{will_paginate(items, will_paginate_options) rescue '' }
          </ul>
        </div>
      </div>
  </div>"
  end

  def blog_categories
    active = 'class="menu-category_list-items_active"'
    html = "<li #{active if @category.nil?}><a href=\"/blog\">#{t("camaleon_cms.blog_all")}</a></li>"
    @post_type.the_categories.each do |cat|
      next if cat.slug == 'uncategorized'
      html << "<li #{active if !@category.nil? && @category.id == cat.id}><a href=\"#{cat.decorate.the_url}\">#{cat.name}</a></li>"
    end

    raw html
  end

  def blog_tags(post)
    tags = post.decorate.the_tags
    return "" if tags.size == 0

    html = '<li><i class="fas fa-tags"></i> '
    tags.each do |tag|
      html << "<a href=\"#{tag.decorate.the_url}\">#{tag.name}</a>"
      html << ", " if tag != tags.last
    end
    html << '</li>'

    raw html
  end

  def language_link
    path = request.path.split("/")
    path.delete("ru")
    path = path.join('/')
    path = '/' if path == ''

    if I18n.locale.to_s == "ru"
      lang_name = "ru"
    else
      path = "/ru#{path}"
      lang_name = "ua"
    end

    raw "<a href=\"#{path}\">#{lang_name.upcase}</a>"
  end

  def meta_hreflang
    lan = current_site.get_languages
    return  if  lan.size < 2
    res = ''
    lan.each do |lang|
      url = @object.present? ? @object.the_url(locale: lang) : cama_url_to_fixed("url_for", {locale: lang})
      res << "<link rel=\"alternate\" hreflang=\"#{lang}\" href=\"#{url}\">"
    end

    raw res
  end

end