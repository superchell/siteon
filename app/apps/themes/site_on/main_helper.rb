module Themes::SiteOn::MainHelper
  def self.included(klass)
    # klass.helper_method [:my_helper_method] rescue "" # here your methods accessible from views
  end

  def site_on_settings(theme)
    # callback to save custom values of fields added in my_theme/views/admin/settings.html.erb
  end

  def site_on_extra_custom_fields(args)

    # Top banner custom field
    args[:fields][:top_banner] = {
      key: 'top_banner',
      label: t('camaleon_cms.admin.custom_field.fields.top_banner'),
      render: theme_view('custom_field/top_banner.html.erb'),
      options: {
        required: true,
        multiple: true,
      },
      extra_fields:[
        {
          type: 'text_box',
          key: 'dimension',
          label: t('camaleon_cms.admin.custom_field.fields.image_dimension'),
          description: t('camaleon_cms.admin.custom_field.fields.image_dimension_descr')
        }
      ]
    }
    # 'How it work' block custom field
    args[:fields][:how_work_item] = {
      key: 'how_work_item',
      label: t('camaleon_cms.admin.custom_field.fields.how_works'),
      render: theme_view('custom_field/how_it_works.html.erb'),
      options: {
        required: false,
        multiple: true,
      }
    }
    # 'Services' block custom field
    args[:fields][:services] = {
      key: 'services',
      label: t('camaleon_cms.admin.custom_field.fields.services'),
      render: theme_view('custom_field/services.html.erb'),
      options: {
        required: false,
        multiple: true,
      }
    }
    # 'Counters' block custom field
    args[:fields][:counters] = {
      key: 'counters',
      label: t('camaleon_cms.admin.custom_field.fields.counters'),
      render: theme_view('custom_field/counters.html.erb'),
      options: {
        required: false,
        multiple: true,
      }
    }
    # 'Prices' block custom field
    args[:fields][:prices] = {
      key: 'prices',
      label: t('camaleon_cms.admin.custom_field.fields.prices'),
      render: theme_view('custom_field/prices.html.erb'),
      options: {
        required: false,
        multiple: true,
      }
    }


  end

  # callback called after theme installed
  def site_on_on_install_theme(theme)
    return if theme.get_option('installed_at').present?

    # Homepage setting field group
    group = theme.add_field_group({name: t('camaleon_cms.admin.field_group.groups.home_page'), slug: "home_page"})
    group.add_field({"name"=>t('camaleon_cms.admin.field_group.fields.home_page'), "slug"=>"home_page", description: t('camaleon_cms.admin.field_group.fields.home_page_descr')},{field_key: "posts", post_types: "all"})

    # Header banner field group
    group = theme.add_field_group({name: t('camaleon_cms.admin.field_group.groups.top_banner'), slug: "top_banner"})
    group.add_field({"name"=>t('camaleon_cms.admin.field_group.fields.top_banner_img'), "slug"=>"top_banner_img", description: t('camaleon_cms.admin.field_group.fields.top_banner_img_descr')},{field_key: "top_banner", translate: true, multiple: false})
    group.add_field({"name"=>t('camaleon_cms.admin.field_group.fields.top_banner_descr_list'), "slug"=>"top_banner_descr_list", description: t('camaleon_cms.admin.field_group.fields.top_banner_descr_list_descr')},{field_key: "text_box", translate: true, multiple: true})

    # "How it works" block field group
    group = theme.add_field_group({name: t('camaleon_cms.admin.field_group.groups.how_works'), slug: "how_works"})
    group.add_field({"name"=>t('camaleon_cms.admin.field_group.fields.title'), "slug"=>"how_works_title", description: t('camaleon_cms.admin.field_group.fields.title_descr', name: t('camaleon_cms.admin.field_group.groups.how_works'))}, {field_key: "text_box", translate: true})
    group.add_field({"name"=>t('camaleon_cms.admin.field_group.fields.subtitle'), "slug"=>"how_works_title2", description: t('camaleon_cms.admin.field_group.fields.subtitle_descr', name: t('camaleon_cms.admin.field_group.groups.how_works'))}, {field_key: "text_box", translate: true})
    group.add_field({"name"=>t('camaleon_cms.admin.field_group.fields.content_blocks'), "slug"=>"how_works_items", description: t('camaleon_cms.admin.field_group.fields.content_blocks_descr', name: t('camaleon_cms.admin.field_group.groups.how_works'))}, {field_key: "how_work_item", translate: true, multiple: true})

    # "Who we are" block field group
    group = theme.add_field_group({name: t('camaleon_cms.admin.field_group.groups.who_we'), slug: "who_we"})
    group.add_field({"name"=>t('camaleon_cms.admin.field_group.fields.title'), "slug"=>"who_we_title", description: t('camaleon_cms.admin.field_group.fields.title_descr', name: t('camaleon_cms.admin.field_group.groups.who_we'))}, {field_key: "text_box", translate: true})
    group.add_field({"name"=>t('camaleon_cms.admin.field_group.fields.description'), "slug"=>"who_we_descr", description: t('camaleon_cms.admin.field_group.fields.description_descr', name: t('camaleon_cms.admin.field_group.groups.who_we'))}, {field_key: "text_area", translate: true})
    group.add_field({"name"=>t('camaleon_cms.admin.field_group.fields.img'), "slug"=>"who_we_big_banner", description: t('camaleon_cms.admin.field_group.fields.img', name: t('camaleon_cms.admin.field_group.groups.who_we'))}, {field_key: "image", multiple: false, required: false })

    # Portfolio block
    group = theme.add_field_group({name: t('camaleon_cms.admin.field_group.groups.portfolio'), slug: "portfolio"})
    group.add_field({"name"=>t('camaleon_cms.admin.field_group.fields.background'), "slug"=>"portfolio_background", description: t('camaleon_cms.admin.field_group.fields.background_descr', name: t('camaleon_cms.admin.field_group.groups.portfolio'))}, {field_key: "image", multiple: false, required: false })
    group.add_field({"name"=>t('camaleon_cms.admin.field_group.fields.title'), "slug"=>"portfolio_title", description: t('camaleon_cms.admin.field_group.fields.title_descr', name: t('camaleon_cms.admin.field_group.groups.portfolio'))}, {field_key: "text_box", translate: true})
    group.add_field({"name"=>t('camaleon_cms.admin.field_group.fields.subtitle'), "slug"=>"portfolio_title2", description: t('camaleon_cms.admin.field_group.fields.subtitle_descr', name: t('camaleon_cms.admin.field_group.groups.portfolio'))}, {field_key: "text_box", translate: true})
    group.add_field({"name"=>t('camaleon_cms.admin.field_group.fields.post_type_from', name: t('camaleon_cms.admin.field_group.groups.portfolio')), "slug"=>"portfolio_post_type"}, {field_key: "select_eval", command: "camaleon_post_types_list_select"})

    # Reviews block
    group = theme.add_field_group({name: t('camaleon_cms.admin.field_group.groups.reviews'), slug: "reviews"})
    group.add_field({"name"=>t('camaleon_cms.admin.field_group.fields.title'), "slug"=>"reviews_title", description: t('camaleon_cms.admin.field_group.fields.title_descr', name: t('camaleon_cms.admin.field_group.groups.reviews'))}, {field_key: "text_box", translate: true})
    group.add_field({"name"=>t('camaleon_cms.admin.field_group.fields.description'), "slug"=>"reviews_descr", description: t('camaleon_cms.admin.field_group.fields.description_descr', name: t('camaleon_cms.admin.field_group.groups.reviews'))}, {field_key: "text_area", translate: true})
    group.add_field({"name"=>t('camaleon_cms.admin.field_group.fields.post_type_from', name: t('camaleon_cms.admin.field_group.groups.reviews')), "slug"=>"reviews_post_type"}, {field_key: "select_eval", command: "camaleon_post_types_list_select"})

    # Technologies block
    group = theme.add_field_group({name: t('camaleon_cms.admin.field_group.groups.tech'), slug: "tech"})
    group.add_field({"name"=>t('camaleon_cms.admin.field_group.fields.title'), "slug"=>"tech_title", description: t('camaleon_cms.admin.field_group.fields.title_descr', name: t('camaleon_cms.admin.field_group.groups.tech'))}, {field_key: "text_box", translate: true})
    group.add_field({"name"=>t('camaleon_cms.admin.field_group.fields.description'), "slug"=>"tech_descr", description: t('camaleon_cms.admin.field_group.fields.description_descr', name: t('camaleon_cms.admin.field_group.groups.reviews'))}, {field_key: "text_area", translate: true})
    group.add_field({"name"=>t('camaleon_cms.admin.field_group.fields.img'), "slug"=>"tech_big_banner", description: t('camaleon_cms.admin.field_group.fields.img_descr', name: t('camaleon_cms.admin.field_group.groups.tech'))}, {field_key: "image", multiple: false, required: false })
    group.add_field({"name"=>t('camaleon_cms.admin.field_group.fields.thumb'), "slug"=>"tech_small_banner", description: t('camaleon_cms.admin.field_group.fields.thumb_descr', name: t('camaleon_cms.admin.field_group.groups.tech'))}, {field_key: "image", multiple: false, required: false })
    group.add_field({"name"=>t('camaleon_cms.admin.field_group.fields.logo'), "slug"=>"tech_logo", description: t('camaleon_cms.admin.field_group.fields.logo_descr', name: t('camaleon_cms.admin.field_group.groups.tech'))}, {field_key: "image", multiple: true, required: false })

    # Services block
    group = theme.add_field_group({name: t('camaleon_cms.admin.field_group.groups.services'), slug: "services"})
    group.add_field({"name"=>t('camaleon_cms.admin.field_group.fields.title'), "slug"=>"services_title", description: t('camaleon_cms.admin.field_group.fields.title_descr', name: t('camaleon_cms.admin.field_group.groups.services'))}, {field_key: "text_box", translate: true})
    group.add_field({"name"=>t('camaleon_cms.admin.field_group.fields.description'), "slug"=>"services_descr", description: t('camaleon_cms.admin.field_group.fields.description_descr', name: t('camaleon_cms.admin.field_group.groups.services'))}, {field_key: "text_area", translate: true})
    group.add_field({"name"=>t('camaleon_cms.admin.field_group.fields.content_blocks'), "slug"=>"services_items", description: t('camaleon_cms.admin.field_group.fields.content_blocks_descr', name: t('camaleon_cms.admin.field_group.groups.services'))},{field_key: "services", translate: true, multiple: true})

    # Counters block
    group = theme.add_field_group({name: t('camaleon_cms.admin.field_group.groups.counters'), slug: "counters"})
    group.add_field({"name"=>t('camaleon_cms.admin.field_group.fields.img'), "slug"=>"counters_banner", description: t('camaleon_cms.admin.field_group.fields.img_descr', name: t('camaleon_cms.admin.field_group.groups.counters'))}, {field_key: "image", multiple: false, required: false })
    group.add_field({"name"=>t('camaleon_cms.admin.field_group.fields.description'), "slug"=>"counters_descr", description: t('camaleon_cms.admin.field_group.fields.description_descr', name: t('camaleon_cms.admin.field_group.groups.counters'))}, {field_key: "text_area", translate: true})
    group.add_field({"name"=>t('camaleon_cms.admin.field_group.fields.content_blocks'), "slug"=>"counters_items", description: t('camaleon_cms.admin.field_group.fields.content_blocks_descr', name: t('camaleon_cms.admin.field_group.groups.counters'))},{field_key: "counters", translate: true, multiple: true})

    # Prices block
    group = theme.add_field_group({name: t('camaleon_cms.admin.field_group.groups.prices'), slug: "prices"})
    group.add_field({"name"=>t('camaleon_cms.admin.field_group.fields.title'), "slug"=>"prices_title", description: t('camaleon_cms.admin.field_group.groups.prices', name: t('camaleon_cms.admin.field_group.groups.prices'))}, {field_key: "text_box", translate: true})
    group.add_field({"name"=>t('camaleon_cms.admin.field_group.fields.description'), "slug"=>"prices_descr", description: t('camaleon_cms.admin.field_group.fields.description_descr', name: t('camaleon_cms.admin.field_group.groups.prices'))}, {field_key: "text_area", translate: true})
    group.add_field({"name"=>t('camaleon_cms.admin.field_group.fields.content_blocks'), "slug"=>"prices_items", description: t('camaleon_cms.admin.field_group.fields.content_blocks_descr', name: t('camaleon_cms.admin.field_group.groups.prices'))},{field_key: "prices", translate: true, multiple: true})

    # Our working block
    group = theme.add_field_group({name: t('camaleon_cms.admin.field_group.groups.our_working'), slug: "our_working"})
    group.add_field({"name"=>t('camaleon_cms.admin.field_group.fields.title'), "slug"=>"our_working_title", description: t('camaleon_cms.admin.field_group.fields.title_descr', name: t('camaleon_cms.admin.field_group.groups.our_working'))}, {field_key: "text_box", translate: true})
    group.add_field({"name"=>t('camaleon_cms.admin.field_group.fields.description'), "slug"=>"our_working_descr", description: t('camaleon_cms.admin.field_group.fields.description_descr', name: t('camaleon_cms.admin.field_group.groups.our_working'))}, {field_key: "text_area", translate: true})
    group.add_field({"name"=>t('camaleon_cms.admin.field_group.fields.img'), "slug"=>"our_working_banner", description: t('camaleon_cms.admin.field_group.fields.img_descr', name: t('camaleon_cms.admin.field_group.groups.our_working'))}, {field_key: "image", multiple: false, required: false })
    group.add_field({"name"=>t('camaleon_cms.admin.field_group.fields.content_blocks'), "slug"=>"our_working_item", description: t('camaleon_cms.admin.field_group.fields.content_blocks_descr', name: t('camaleon_cms.admin.field_group.groups.our_working'))},{field_key: "top_banner", translate: true, multiple: true})

    # Brands block
    group = theme.add_field_group({name: t('camaleon_cms.admin.field_group.groups.brands'), slug: "brands"})
    group.add_field({"name"=>t('camaleon_cms.admin.field_group.fields.logo'), "slug"=>"brands_item", description: t('camaleon_cms.admin.field_group.fields.logo_descr', name: t('camaleon_cms.admin.field_group.groups.brands'))}, {field_key: "image", multiple: true, required: false })

    # Footer
    group = theme.add_field_group({name: "Footer", slug: "footer"})
    group.add_field({"name"=>t('camaleon_cms.admin.field_group.fields.left_column'), "slug"=>"footer_left"}, {field_key: "editor", translate: true, default_value: "<h4>My Bunker</h4><p>Some Address 987,<br> +34 9054 5455, <br> Madrid, Spain. </p>"})
    group.add_field({"name"=>t('camaleon_cms.admin.field_group.fields.center_column'), "slug"=>"footer_center"}, {field_key: "editor", translate: true, default_value: "<h4>My Links</h4> <p><a href='#'>Dribbble</a><br> <a href='#'>Twitter</a><br> <a href='#'>Facebook</a></p>"})
    group.add_field({"name"=>t('camaleon_cms.admin.field_group.fields.right_column'), "slug"=>"footer_right"}, {field_key: "editor", translate: true, default_value: "<h4>About Theme</h4><p>This cute theme was created to showcase your work in a simple way. Use it wisely.</p>"})

  end

  # callback executed after theme uninstalled
  def site_on_on_uninstall_theme(theme)
    theme.get_field_groups().destroy_all
    theme.destroy
  end

  def camaleon_post_types_list_select
    res = []
    current_site.the_post_types.decorate.each {|p| res << "<option value='#{p.the_slug}'>#{p.the_title}</option>" }
    res.join("").html_safe
  end
end
