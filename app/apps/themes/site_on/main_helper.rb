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
    # Shortly view custom field
    args[:fields][:shortly_view] = {
      key: 'shortly_view',
      label: t('camaleon_cms.admin.custom_field.fields.shortly_view'),
      render: theme_view('custom_field/shortly_view.html.erb'),
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

    # Home page post type
    install_homepage

    # Portfolio post type
    install_portfolio

    # Reviews
    install_reviews


    # Template custom fields
    install_theme_settings(theme)

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

  def install_theme_settings(theme)
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
    group.add_field({"name"=>t('camaleon_cms.admin.field_group.fields.description'), "slug"=>"who_we_descr", description: t('camaleon_cms.admin.field_group.fields.description_descr', name: t('camaleon_cms.admin.field_group.groups.who_we'))}, {field_key: "editor", translate: true})
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
    # group.add_field({"name"=>t('camaleon_cms.admin.field_group.fields.thumb'), "slug"=>"tech_small_banner", description: t('camaleon_cms.admin.field_group.fields.thumb_descr', name: t('camaleon_cms.admin.field_group.groups.tech'))}, {field_key: "image", multiple: false, required: false })
    group.add_field({"name"=>t('camaleon_cms.admin.field_group.fields.logo'), "slug"=>"tech_logo", description: t('camaleon_cms.admin.field_group.fields.logo_descr', name: t('camaleon_cms.admin.field_group.groups.tech'))}, {field_key: "image", multiple: true, required: false, versions: '263x123' })

    # Services block
    group = theme.add_field_group({name: t('camaleon_cms.admin.field_group.groups.services'), slug: "services"})
    group.add_field({"name"=>t('camaleon_cms.admin.field_group.fields.title'), "slug"=>"services_title", description: t('camaleon_cms.admin.field_group.fields.title_descr', name: t('camaleon_cms.admin.field_group.groups.services'))}, {field_key: "text_box", translate: true})
    group.add_field({"name"=>t('camaleon_cms.admin.field_group.fields.description'), "slug"=>"services_descr", description: t('camaleon_cms.admin.field_group.fields.description_descr', name: t('camaleon_cms.admin.field_group.groups.services'))}, {field_key: "editor", translate: true})
    group.add_field({"name"=>t('camaleon_cms.admin.field_group.fields.content_blocks'), "slug"=>"services_items", description: t('camaleon_cms.admin.field_group.fields.content_blocks_descr', name: t('camaleon_cms.admin.field_group.groups.services'))},{field_key: "services", translate: true, multiple: true})

    # Counters block
    group = theme.add_field_group({name: t('camaleon_cms.admin.field_group.groups.counters'), slug: "counters"})
    group.add_field({"name"=>t('camaleon_cms.admin.field_group.fields.img'), "slug"=>"counters_banner", description: t('camaleon_cms.admin.field_group.fields.img_descr', name: t('camaleon_cms.admin.field_group.groups.counters'))}, {field_key: "image", multiple: false, required: false })
    group.add_field({"name"=>t('camaleon_cms.admin.field_group.fields.description'), "slug"=>"counters_descr", description: t('camaleon_cms.admin.field_group.fields.description_descr', name: t('camaleon_cms.admin.field_group.groups.counters'))}, {field_key: "editor", translate: true})
    group.add_field({"name"=>t('camaleon_cms.admin.field_group.fields.content_blocks'), "slug"=>"counters_items", description: t('camaleon_cms.admin.field_group.fields.content_blocks_descr', name: t('camaleon_cms.admin.field_group.groups.counters'))},{field_key: "counters", translate: true, multiple: true})

    # Prices block
    group = theme.add_field_group({name: t('camaleon_cms.admin.field_group.groups.prices'), slug: "prices"})
    group.add_field({"name"=>t('camaleon_cms.admin.field_group.fields.title'), "slug"=>"prices_title", description: t('camaleon_cms.admin.field_group.groups.prices', name: t('camaleon_cms.admin.field_group.groups.prices'))}, {field_key: "text_box", translate: true})
    group.add_field({"name"=>t('camaleon_cms.admin.field_group.fields.description'), "slug"=>"prices_descr", description: t('camaleon_cms.admin.field_group.fields.description_descr', name: t('camaleon_cms.admin.field_group.groups.prices'))}, {field_key: "editor", translate: true})
    group.add_field({"name"=>t('camaleon_cms.admin.field_group.fields.content_blocks'), "slug"=>"prices_items", description: t('camaleon_cms.admin.field_group.fields.content_blocks_descr', name: t('camaleon_cms.admin.field_group.groups.prices'))},{field_key: "prices", translate: true, multiple: true})

    # Our working block
    group = theme.add_field_group({name: t('camaleon_cms.admin.field_group.groups.our_working'), slug: "our_working"})
    group.add_field({"name"=>t('camaleon_cms.admin.field_group.fields.title'), "slug"=>"our_working_title", description: t('camaleon_cms.admin.field_group.fields.title_descr', name: t('camaleon_cms.admin.field_group.groups.our_working'))}, {field_key: "text_box", translate: true})
    group.add_field({"name"=>t('camaleon_cms.admin.field_group.fields.description'), "slug"=>"our_working_descr", description: t('camaleon_cms.admin.field_group.fields.description_descr', name: t('camaleon_cms.admin.field_group.groups.our_working'))}, {field_key: "editor", translate: true})
    group.add_field({"name"=>t('camaleon_cms.admin.field_group.fields.img'), "slug"=>"our_working_banner", description: t('camaleon_cms.admin.field_group.fields.img_descr', name: t('camaleon_cms.admin.field_group.groups.our_working'))}, {field_key: "image", multiple: false, required: false })
    group.add_field({"name"=>t('camaleon_cms.admin.field_group.fields.content_blocks'), "slug"=>"our_working_item", description: t('camaleon_cms.admin.field_group.fields.content_blocks_descr', name: t('camaleon_cms.admin.field_group.groups.our_working'))},{field_key: "top_banner", translate: true, multiple: true})

    # Brands block
    group = theme.add_field_group({name: t('camaleon_cms.admin.field_group.groups.brands'), slug: "brands"})
    group.add_field({"name"=>t('camaleon_cms.admin.field_group.fields.logo'), "slug"=>"brands_item", description: t('camaleon_cms.admin.field_group.fields.logo_descr', name: t('camaleon_cms.admin.field_group.groups.brands'))}, {field_key: "image", multiple: true, required: false })

    # Footer
    group = theme.add_field_group({name: "Footer", slug: "footer"})
    group.add_field({"name"=>t('camaleon_cms.admin.field_group.fields.left_column'), "slug"=>"footer_left"}, {field_key: "editor", translate: true, default_value: '<h4 class="iq-tw-6 iq-pb-10">Address</h4><p>1234 North Avenue Luke Lane, South Bend, IN 360001</p>'})
    group.add_field({"name"=>t('camaleon_cms.admin.field_group.fields.center_column'), "slug"=>"footer_center"}, {field_key: "editor", translate: true, default_value: '<h4 class="iq-tw-6 iq-pb-10">Phone</h4><p>+0123 456 789 <br>Mon-Fri 8:00am - 8:00pm<br></p>'})
    group.add_field({"name"=>t('camaleon_cms.admin.field_group.fields.right_column'), "slug"=>"footer_right"}, {field_key: "editor", translate: true, default_value: '<h4 class="iq-tw-6 iq-pb-10">Mail</h4><p>support@sofbox.com <br>24 X 7 online support<br></p>'})

  end

  def install_homepage
    hp = CamaleonCms::TermTaxonomy.where(slug: 'home').first
    if hp.nil?
      hp = current_site.post_types.create(name: t('camaleon_cms.post_type.name.homepage'), slug: "home", description: t('camaleon_cms.post_type.descr.homepage'))
      hp.set_settings({
                        has_category: false,
                        has_tags: false,
                        has_summary:false,
                        has_content: false,
                        has_comments: false,
                        has_picture: false,
                        has_template: true,
                        has_seo: true,
                        not_deleted: false,
                        has_layout: false,
                        icon: 'home',
                        has_single_category: false,
                        has_featured: false,
                        has_parent_structure: false
                      })
    end
  end

  def install_portfolio
    pp = CamaleonCms::TermTaxonomy.where(slug: 'portfolio').first
    if pp.nil?
      pp = current_site.post_types.create(name: t('camaleon_cms.post_type.name.portfolio'), slug: "portfolio", description: t('camaleon_cms.post_type.descr.portfolio'))
      pp.set_settings({
                        has_category: false,
                        has_tags: false,
                        has_summary:false,
                        has_content: false,
                        has_comments: false,
                        has_picture: true,
                        posts_thumb_versions: '360x263',
                        has_template: true,
                        has_seo: true,
                        not_deleted: false,
                        has_layout: false,
                        icon: 'vcard',
                        has_single_category: false,
                        has_featured: false,
                        has_parent_structure: false
                      })

      # Portfolio settings group
      pp_group = pp.add_field_group({name: t('camaleon_cms.admin.field_group.groups.portfolio_settings'), slug: "portfolio_settings"})

      # TODO remove this hard coding from typicaly package
      project_types = [{title: t('camaleon_cms.project_type.ecommerce'), value: "ecommerce"}, {title: t('camaleon_cms.project_type.card'), value: "card"}, {title: t('camaleon_cms.project_type.landing'), value: "landing"}, {title: t('camaleon_cms.project_type.catalog'), value: "catalog"}, {title: t('camaleon_cms.project_type.corp'), value: "corp"}]

      pp_group.add_field({"name"=>t('camaleon_cms.admin.field_group.fields.project_type'), "slug"=>"project_type", description: t('camaleon_cms.admin.field_group.fields.project_type_descr')},{field_key: "select", translate: true, multiple: false, multiple_options: project_types})
      pp_group.add_field({"name"=>t('camaleon_cms.admin.field_group.fields.potfolio_background1'), "slug"=>"potfolio_background1"},{field_key: "colorpicker", multiple: false, color_format: "rgb"})
      pp_group.add_field({"name"=>t('camaleon_cms.admin.field_group.fields.potfolio_background2'), "slug"=>"potfolio_background2"},{field_key: "colorpicker", multiple: false, color_format: "rgb"})
      pp_group.add_field({"name"=>t('camaleon_cms.admin.field_group.fields.potfolio_background3'), "slug"=>"potfolio_background3"},{field_key: "colorpicker", multiple: false, color_format: "rgb"})
      pp_group.add_field({"name"=>t('camaleon_cms.admin.field_group.fields.potfolio_button'), "slug"=>"potfolio_button"},{field_key: "colorpicker", multiple: false, color_format: "hex"})

      # Top block
      pp_group = pp.add_field_group({name: t('camaleon_cms.admin.field_group.groups.portfolio_top'), slug: "portfolio_top"})
      pp_group.add_field({"name"=>t('camaleon_cms.admin.field_group.fields.portfolio_logo'), "slug"=>"portfolio_logo"},{field_key: "image", multiple: false})
      pp_group.add_field({"name"=>t('camaleon_cms.admin.field_group.fields.potfolio_url'), "slug"=>"potfolio_url"},{field_key: "url", multiple: false})
      pp_group.add_field({"name"=>t('camaleon_cms.admin.field_group.fields.shortly_descr'), "slug"=>"portfolio_top_descr"}, {field_key: "editor", translate: true})
      pp_group.add_field({"name"=>t('camaleon_cms.admin.field_group.fields.img'), "slug"=>"portfolio_top_img"},{field_key: "image", multiple: false})

      # Portfolio purpose block
      pp_group = pp.add_field_group({name: t('camaleon_cms.admin.field_group.groups.portfolio_purpose'), slug: "portfolio_purpose"})
      pp_group.add_field({"name"=>t('camaleon_cms.admin.field_group.fields.title'), "slug"=>"purpose_title"}, {field_key: "text_box", translate: true})
      pp_group.add_field({"name"=>t('camaleon_cms.admin.field_group.fields.img'), "slug"=>"purpose_img"},{field_key: "image", multiple: false})
      pp_group.add_field({"name"=>t('camaleon_cms.admin.field_group.fields.shortly_descr'), "slug"=>"purpose_descr"}, {field_key: "editor", translate: true})

      # Mobile view block
      pp_group = pp.add_field_group({name: t('camaleon_cms.admin.field_group.groups.portfolio_mobile_view'), slug: "portfolio_mobile_view"})
      pp_group.add_field({"name"=>t('camaleon_cms.admin.field_group.fields.title'), "slug"=>"mobile_view_title"}, {field_key: "text_box", translate: true})
      pp_group.add_field({"name"=>t('camaleon_cms.admin.field_group.fields.shortly_descr'), "slug"=>"mobile_view_descr"}, {field_key: "editor", translate: true})
      pp_group.add_field({"name"=>t('camaleon_cms.admin.field_group.fields.thumb'), "slug"=>"mobile_view_thumb"},{field_key: "image", multiple: false})
      pp_group.add_field({"name"=>t('camaleon_cms.admin.field_group.fields.img'), "slug"=>"mobile_view_img"},{field_key: "image", multiple: false})

      # Features block
      pp_group = pp.add_field_group({name: t('camaleon_cms.admin.field_group.groups.portfolio_features'), slug: "portfolio_features"})
      pp_group.add_field({"name"=>t('camaleon_cms.admin.field_group.fields.title'), "slug"=>"features_title"}, {field_key: "text_box", translate: true})
      pp_group.add_field({"name"=>t('camaleon_cms.admin.field_group.fields.shortly_descr'), "slug"=>"features_descr"}, {field_key: "editor", translate: true})
      pp_group.add_field({"name"=>t('camaleon_cms.admin.field_group.fields.img'), "slug"=>"features_img"},{field_key: "image", multiple: false})
      pp_group.add_field({"name"=>t('camaleon_cms.admin.field_group.fields.description2'), "slug"=>"features_descr2"}, {field_key: "editor", translate: true})
      pp_group.add_field({"name"=>t('camaleon_cms.admin.field_group.fields.dynamic_list'), "slug"=>"features_dynamic_list"}, {field_key: "shortly_view", translate: true, multiple: true})

      # Results block
      pp_group = pp.add_field_group({name: t('camaleon_cms.admin.field_group.groups.portfolio_results'), slug: "portfolio_results"})
      pp_group.add_field({"name"=>t('camaleon_cms.admin.field_group.fields.title'), "slug"=>"results_title"}, {field_key: "text_box", translate: true})
      pp_group.add_field({"name"=>t('camaleon_cms.admin.field_group.fields.dynamic_list'), "slug"=>"results_dynamic_list"}, {field_key: "shortly_view", translate: true, multiple: true})

      # Bottom block
      pp_group = pp.add_field_group({name: t('camaleon_cms.admin.field_group.groups.portfolio_bottom'), slug: "portfolio_bottom"})
      pp_group.add_field({"name"=>t('camaleon_cms.admin.field_group.fields.title'), "slug"=>"bottom_title"}, {field_key: "text_box", translate: true})
      pp_group.add_field({"name"=>t('camaleon_cms.admin.field_group.fields.img'), "slug"=>"bottom_img"},{field_key: "image", multiple: false})

    end
  end

  def install_reviews
    rp = CamaleonCms::TermTaxonomy.where(slug: 'reviews').first
    if rp.nil?
      rp = current_site.post_types.create(name: t('camaleon_cms.post_type.name.reviews'), slug: "reviews", description: t('camaleon_cms.post_type.name.reviews'))
      rp.set_settings({
                        has_category: false,
                        has_tags: false,
                        has_summary:false,
                        has_content: true,
                        has_comments: false,
                        has_picture: true,
                        posts_thumb_versions: '80x80',
                        has_template: true,
                        has_seo: false,
                        not_deleted: false,
                        has_layout: false,
                        icon: 'comment',
                        has_single_category: false,
                        has_featured: false,
                        has_parent_structure: false
                      })

      rp_group = rp.add_field_group({name: t('camaleon_cms.admin.field_group.groups.reviews_fields'), slug: "reviews_fields"})
      rp_group.add_field({"name"=>t('camaleon_cms.admin.field_group.fields.title'), "slug"=>"reviews_caption"}, {field_key: "text_box", translate: true})
    end
  end

  def form_bot_check(form)
    abort("Заблукав, падлюко?") if params[:who_are_you].present?
  end

  def send_data_to_crm(args)
    values = {
      name: args[:values].permit(:c3).present? ? args[:values].permit(:c2).values.first : "Лид без имени",
      phone: args[:values].permit(:c3).present? ? args[:values].permit(:c3).values.first : args[:values].permit(:c2).values.first,
      email: args[:values].permit(:c4).present? ? args[:values].permit(:c4).values.first : ""
    }

    b24 = B24.new
    b24.add_crm_lead(values)
  end

  def aws_uploader_hook(args)
    args[:aws_settings][:aws_file_upload_settings] = lambda{|settings|
      settings[:cache_control] = 'max-age=15552000, public'
      settings[:expires] = "#{1.year.from_now.to_formatted_s(:rfc822)}"
      settings
    }
  end

  def before_app_load
    shortcode_add("funnel_form", theme_view('partials/funnel_form'))
  end
end
