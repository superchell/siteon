Rails.application.routes.draw do

  constraints(host: /^www\./i) do
    match '(*any)' => redirect { |params, request|
      URI.parse(request.url).tap { |uri| uri.host.sub!(/^www\./i, '') }.to_s
    }, via: [:get, :post]
  end

  scope PluginRoutes.system_info["relative_url_root"], as: "cama" do
    scope "(:locale)", locale: /#{PluginRoutes.all_locales}/, :defaults => {  } do
      get "home/:id", to: redirect("/")
      get "home", to: redirect("/")

      get "reviews/:id", to: redirect("/")
      get "reviews", to: redirect("/")

      get "portfolio", to: redirect("/")
      get "page", to: redirect("/")

      controller "camaleon_cms/frontend" do
        valid_types = ['blog']

        get ':label/:post_tag_slug' => :post_tag, as: 'post_tag_s', constraints: ->(request) {
          multilingual_segment = "tag"
          request.params[:post_tag_slug].match(/[a-zA-Z0-9_=\s\-\/]+/) && request.params[:label].in?(multilingual_segment)
        }
        get ':post_type/:category_slug/:slug' => :post, as: 'full_hierarchy_post', constraints: ->(request) {
          valid_types.include?(request.params[:post_type]) &&
          request.params[:category_slug].match(/[a-zA-Z0-9_=\s\-\/]+/) &&
          request.params[:slug].match(/[a-zA-Z0-9_=\s\-\/]+/)
        }
        get ':post_type/:category_slug' => :category_hierarchy, as: 'category_hierarchy', constraints: ->(request) {
          valid_types.include?(request.params[:post_type])
        }
      end
    end
  end
end
