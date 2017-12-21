Rails.application.routes.draw do

  constraints(host: /^www\./i) do
    match '(*any)' => redirect { |params, request|
      URI.parse(request.url).tap { |uri| uri.host.sub!(/^www\./i, '') }.to_s
    }, via: [:get, :post]
  end

  scope PluginRoutes.system_info["relative_url_root"], as: "cama" do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    get "home/:id", to: redirect("/")
    get "home", to: redirect("/")

    get "reviews/:id", to: redirect("/")
    get "reviews", to: redirect("/")

    get "portfolio", to: redirect("/")
  end
end
