class GetResponseController < ApplicationController
  def set_contact_tag
    g = GetResponse.new
    g.email = params["email"] if params["email"].present?
    g.tag = params["tag"] if params["tag"].present?
    g.add_contact_tag

    render :json => "ok"
  end
end
