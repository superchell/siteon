module CamaleonCms::Frontend::CustomHelper

  def get_background_image(url)
    r = ''
    if url.present?
      r = "background-image: url(#{url});"
    end
    r
  end

  def theme_img_url (path)
    asset_url theme_asset_path "images/#{path}"
  end

end