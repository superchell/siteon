Rails.application.config.to_prepare do
  CamaleonCms::PostType.class_eval do
    # return all available route formats of this post type for content posts
    def contents_route_formats
      {
        "post_of_post_type" => "<code>/group/:post_type_id-:title/:slug</code><br>  (Sample: http://localhost.com/group/17-services/myservice.html)",
        "post_of_category" => "<code>/category/:category_id-:title/:slug</code><br>  (Sample: http://localhost.com/category/17-services/myservice.html)",
        "post_of_category_post_type" => "<code>/:post_type_title/category/:category_id-:title/:slug</code><br>  (Sample: http://localhost.com/services/category/17-services/myservice.html)",
        "post_of_posttype" => "<code>/:post_type_title/:slug</code><br>  (Sample: http://localhost.com/services/myservice.html)",
        "post" => "<code>/:slug</code><br>  (Sample: http://localhost.com/myservice.html)",
        "full_hierarchy_post" => "<code>/:post_type_slug/:category_slug/:slug</code><br>  (Sample: http://localhost.com/blog/services/myservice.html)",
        "hierarchy_post" => "<code>/:parent1_slug/:parent2_slug/.../:slug</code><br>  (Sample: http://localhost.com/item-1/item-1-1/item-111.html)"
      }
    end
  end
end