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
      label: 'Top Banner',
      render: theme_view('custom_field/top_banner.html.erb'),
      options: {
        required: true,
        multiple: true,
      },
      extra_fields:[
        {
          type: 'text_box',
          key: 'dimension',
          label: 'Dimensions',
          description: 'Crop images with dimension (widthxheight), sample:<br>400x300 | 400x | x300 | ?400x?500 | ?1400x (? => maximum, empty => auto)'
        }
      ]
    }
    # 'How it work' block custom field
    args[:fields][:how_work_item] = {
      key: 'how_work_item',
      label: 'How it works',
      render: theme_view('custom_field/how_it_works.html.erb'),
      options: {
        required: false,
        multiple: true,
      }
    }
    # 'Services' block custom field
    args[:fields][:services] = {
      key: 'services',
      label: 'Services',
      render: theme_view('custom_field/services.html.erb'),
      options: {
        required: false,
        multiple: true,
      }
    }
    # 'Counters' block custom field
    args[:fields][:counters] = {
      key: 'counters',
      label: 'Counters',
      render: theme_view('custom_field/counters.html.erb'),
      options: {
        required: false,
        multiple: true,
      }
    }
    # 'Prices' block custom field
    args[:fields][:prices] = {
      key: 'prices',
      label: 'Prices',
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
    group = theme.add_field_group({name: "Home Page", slug: "home_page"})
    group.add_field({"name"=>"Home Page", "slug"=>"home_page", description: "Select your home page"},{field_key: "posts", post_types: "all"})

    # Header banner field group
    group = theme.add_field_group({name: "Home Top Banner", slug: "top_banner"})
    group.add_field({"name"=>"Top banner picture", "slug"=>"top_banner_img", description: "Add banner on home page"},{field_key: "top_banner", translate: true, multiple: false})
    group.add_field({"name"=>"Top banner list", "slug"=>"top_banner_descr_list", description: "Add banner description on home page"},{field_key: "text_box", translate: true, multiple: true})

    # "How it works" block field group
    group = theme.add_field_group({name: "How it works?", slug: "how_works"})
    group.add_field({"name"=>"Title", "slug"=>"how_works_title", description: "Add 'How it works' title"}, {field_key: "text_box", translate: true})
    group.add_field({"name"=>"Second Title", "slug"=>"how_works_title2", description: "Add 'How it works' second title"}, {field_key: "text_box", translate: true})
    group.add_field({"name"=>"Content block items", "slug"=>"how_works_items", description: "Add 'How it works' content items"}, {field_key: "how_work_item", translate: true, multiple: true})

    # "Who we are" block field group
    group = theme.add_field_group({name: "Who we are?", slug: "who_we"})
    group.add_field({"name"=>"Title", "slug"=>"who_we_title", description: "Add 'Who we are' title"}, {field_key: "text_box", translate: true})
    group.add_field({"name"=>"Description", "slug"=>"who_we_descr", description: "Add 'Who we are' description"}, {field_key: "text_area", translate: true})
    group.add_field({"name"=>"Big banner", "slug"=>"who_we_big_banner", description: "Add 'Who we are' block banner image"}, {field_key: "image", multiple: false, required: false })

    # Portfolio block
    group = theme.add_field_group({name: "Portfolio", slug: "portfolio"})
    group.add_field({"name"=>"Background image", "slug"=>"portfolio_background", description: "Add 'Portfolio' block image"}, {field_key: "image", multiple: false, required: false })
    group.add_field({"name"=>"Title", "slug"=>"portfolio_title", description: "Add 'Portfolio' block title"}, {field_key: "text_box", translate: true})
    group.add_field({"name"=>"Second Title", "slug"=>"portfolio_title2", description: "Add 'Portfolio' block second title"}, {field_key: "text_box", translate: true})
    group.add_field({"name"=>"Recent portfolio from", "slug"=>"portfolio_post_type"}, {field_key: "select_eval", command: "camaleon_post_types_list_select"})

    # Reviews block
    group = theme.add_field_group({name: "Reviews", slug: "reviews"})
    group.add_field({"name"=>"Title", "slug"=>"reviews_title", description: "Add Reviews block title"}, {field_key: "text_box", translate: true})
    group.add_field({"name"=>"Description", "slug"=>"reviews_descr", description: "Add Reviews block description"}, {field_key: "text_area", translate: true})
    group.add_field({"name"=>"Recent reviews from", "slug"=>"reviews_post_type"}, {field_key: "select_eval", command: "camaleon_post_types_list_select"})

    # Technologies block
    group = theme.add_field_group({name: "Technologies", slug: "tech"})
    group.add_field({"name"=>"Title", "slug"=>"tech_title", description: "Add Technologies block title"}, {field_key: "text_box", translate: true})
    group.add_field({"name"=>"Description", "slug"=>"tech_descr", description: "Add Technologies block description"}, {field_key: "text_area", translate: true})
    group.add_field({"name"=>"Big banner", "slug"=>"tech_big_banner", description: "Add big banner image"}, {field_key: "image", multiple: false, required: false })
    group.add_field({"name"=>"Small banner", "slug"=>"tech_small_banner", description: "Add small banner image"}, {field_key: "image", multiple: false, required: false })
    group.add_field({"name"=>"Technology logo", "slug"=>"tech_logo", description: "Add technology logo"}, {field_key: "image", multiple: true, required: false })

    # Services block
    group = theme.add_field_group({name: "Services", slug: "services"})
    group.add_field({"name"=>"Title", "slug"=>"services_title", description: "Add Services block title"}, {field_key: "text_box", translate: true})
    group.add_field({"name"=>"Description", "slug"=>"services_descr", description: "Add Services block description"}, {field_key: "text_area", translate: true})
    group.add_field({"name"=>"Services items", "slug"=>"services_items", description: "Add Services block item"},{field_key: "services", translate: true, multiple: true})

    # Counters block
    group = theme.add_field_group({name: "Counters", slug: "counters"})
    group.add_field({"name"=>"Banner", "slug"=>"counters_banner", description: "Add Counters banner image"}, {field_key: "image", multiple: false, required: false })
    group.add_field({"name"=>"Description", "slug"=>"counters_descr", description: "Add Counters block description"}, {field_key: "text_area", translate: true})
    group.add_field({"name"=>"Counters items", "slug"=>"counters_items", description: "Add Counters block item"},{field_key: "counters", translate: true, multiple: true})

    # Prices block
    group = theme.add_field_group({name: "Prices", slug: "prices"})
    group.add_field({"name"=>"Title", "slug"=>"prices_title", description: "Add Prices block title"}, {field_key: "text_box", translate: true})
    group.add_field({"name"=>"Description", "slug"=>"prices_descr", description: "Add Prices block description"}, {field_key: "text_area", translate: true})
    group.add_field({"name"=>"Prices items", "slug"=>"prices_items", description: "Add Prices block item"},{field_key: "prices", translate: true, multiple: true})

    # Our working block
    group = theme.add_field_group({name: "Our working", slug: "our_working"})
    group.add_field({"name"=>"Title", "slug"=>"our_working_title", description: "Add Our working block title"}, {field_key: "text_box", translate: true})
    group.add_field({"name"=>"Description", "slug"=>"our_working_descr", description: "Add Our working block description"}, {field_key: "text_area", translate: true})
    group.add_field({"name"=>"Banner", "slug"=>"our_working_banner", description: "Add Our working banner image"}, {field_key: "image", multiple: false, required: false })
    group.add_field({"name"=>"Our working item", "slug"=>"our_working_item", description: "Add Our working block item"},{field_key: "top_banner", translate: true, multiple: true})

    # Brands block
    group = theme.add_field_group({name: "Brands", slug: "brands"})
    group.add_field({"name"=>"Brands item", "slug"=>"brands_item", description: "Add Brand logo"}, {field_key: "image", multiple: true, required: false })

    # Footer
    group = theme.add_field_group({name: "Footer", slug: "footer"})
    group.add_field({"name"=>"Column Left", "slug"=>"footer_left"}, {field_key: "editor", translate: true, default_value: "<h4>My Bunker</h4><p>Some Address 987,<br> +34 9054 5455, <br> Madrid, Spain. </p>"})
    group.add_field({"name"=>"Column Center", "slug"=>"footer_center"}, {field_key: "editor", translate: true, default_value: "<h4>My Links</h4> <p><a href='#'>Dribbble</a><br> <a href='#'>Twitter</a><br> <a href='#'>Facebook</a></p>"})
    group.add_field({"name"=>"Column Right", "slug"=>"footer_right"}, {field_key: "editor", translate: true, default_value: "<h4>About Theme</h4><p>This cute theme was created to showcase your work in a simple way. Use it wisely.</p>"})

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
