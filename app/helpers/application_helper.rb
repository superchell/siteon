module ApplicationHelper
  include CamaleonCms::Frontend::CustomHelper

  def component(component_name, locals = {}, &block)
    name = component_name.split("/").last
    render("components/#{component_name}/#{name}", locals, &block)
  end

  alias c component
end
