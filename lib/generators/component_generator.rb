class ComponentGenerator < Rails::Generators::Base
  argument :component_name, required: true, desc: "Component name, e.g: button"

  def create_view_file
    create_file "#{component_path}/_#{file_name}.html.erb"
  end

  def create_css_file
    create_file "#{component_path}/#{file_name}.css"
  end

  def create_js_file
    create_file "#{component_path}/#{file_name}.js" do
      # require component's CSS inside JS automatically
      "import \"./#{file_name}.css\";\n"
    end
  end

  protected

  def component_path
    path = "frontend/components/"
    # build subdirectories path
    if component_name.count("/") > 0
      subdir_arr = component_name.split('/')
      path = "#{path}#{subdir_arr.slice(0, subdir_arr.count - 1 ).join('/')}/"
    end

    "#{path}#{file_name}"
  end

  def file_name
    component_name.split("/").last
  end
end