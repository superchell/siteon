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

  def inner_post_type?(slug)
    ['blog', 'page'].include? slug
  end

  def filtered_breadcrumbs
    if @post_type.slug == 'page' && !@post.nil?
      raw "<li class='active'>#{@post.the_title}</li>"
    elsif !@post.nil?
      raw @post.the_breadcrumb(false)
    else
      raw @post_type.the_breadcrumb
    end
  end

  def siteon_pagination(items, *will_paginate_options)
    will_paginate_options = will_paginate_options.extract_options!
    will_paginate_options[:previous_label] = '<i class="ion-ios-arrow-left"></i>'
    will_paginate_options[:next_label] = '<i class="ion-ios-arrow-right"></i>'
    "<div class='row iq-mt-80'>
      <div class='col-lg-12 col-md-12 text-center'>
        <ul class='pagination pagination-lg'>
          #{will_paginate(items, will_paginate_options) rescue '' }
        </ul>
      </div>
    </div>"
  end

end