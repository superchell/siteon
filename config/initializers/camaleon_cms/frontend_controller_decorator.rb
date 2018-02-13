Rails.application.config.to_prepare do
  CamaleonCms::FrontendController.class_eval do
    # render a post
    def post
      if params[:draft_id].present?
        draft_render
      else
        render_post(@post || params[:slug].to_s.split("/").last, true)
      end
    end


    # render a post
    # post_or_slug_or_id: slug_post | id post | post object
    # from_url: true/false => true (true, permit eval hooks "on_render_post")
    def render_post(post_or_slug_or_id, from_url = false)
      if post_or_slug_or_id.is_a?(String) # slug
        @post = current_site.the_posts.find_by_slug(post_or_slug_or_id)
      elsif post_or_slug_or_id.is_a?(Integer) # id
        @post = current_site.the_posts.where(id: post_or_slug_or_id).first
      else # model
        @post = post_or_slug_or_id
      end

      unless @post.present?
        if params[:format] == 'html' || !params[:format].present?
          page_not_found()
        else
          head 404
        end
      else
        @post = @post.decorate
        return page_not_found unless post_path_exist?

        @object = @post
        @cama_visited_post = @post
        @post_type = @post.the_post_type
        @comments = @post.the_comments
        @categories = @post.the_categories

        @post.increment_visits!
        # todo: can_visit? if not redirect home page
        home_page = @_site_options[:home_page] rescue nil
        if lookup_context.template_exists?("page_#{@post.id}")
          r_file = "page_#{@post.id}"
        elsif @post.get_template(@post_type).present? && lookup_context.template_exists?(@post.get_template(@post_type))
          r_file = @post.get_template(@post_type)
        elsif home_page.present? && @post.id.to_s == home_page
          r_file = "index"
        elsif lookup_context.template_exists?("post_types/#{@post_type.the_slug}/single")
          r_file = "post_types/#{@post_type.the_slug}/single"
        elsif lookup_context.template_exists?("#{@post_type.slug}")
          r_file = "#{@post_type.slug}"
        else
          r_file = "single"
        end

        layout_ = nil
        meta_layout = @post.get_layout(@post_type)
        layout_ = meta_layout if meta_layout.present? && lookup_context.template_exists?("layouts/#{meta_layout}")
        r = {post: @post, post_type: @post_type, layout: layout_, render: r_file}
        hooks_run("on_render_post", r) if from_url
        render r[:render], (!r[:layout].nil? ? {layout: r[:layout]} : {})
      end
    end

    # render category list
    def category_hierarchy
      begin
        @category = current_site.the_full_categories.find_by_slug(params[:category_slug]).decorate
        @post_type = @category.the_post_type
        return page_not_found if @post_type.slug != params[:post_type]
      rescue
        return page_not_found
      end
      @cama_visited_category = @category
      @children = @category.children.no_empty.decorate
      @posts = @category.the_posts.paginate(:page => params[:page], :per_page => current_site.front_per_page).eager_load(:metas)
      r_file = lookup_context.template_exists?("category_#{@category.the_slug}") ? "category_#{@category.the_slug}" : nil  # specific template category with specific slug within a posttype
      r_file = lookup_context.template_exists?("post_types/#{@post_type.the_slug}/category") ? "post_types/#{@post_type.the_slug}/category" : nil unless r_file.present? # default template category for all categories within a posttype
      r_file = lookup_context.template_exists?("categories/#{@category.the_slug}") ? "categories/#{@category.the_slug}" : 'category' unless r_file.present?  # default template category for all categories for all posttypes

      layout_ = lookup_context.template_exists?("layouts/post_types/#{@post_type.the_slug}/category") ? "post_types/#{@post_type.the_slug}/category" : nil unless layout_.present? # layout for all categories within a posttype
      layout_ = lookup_context.template_exists?("layouts/categories/#{@category.the_slug}") ? "categories/#{@category.the_slug}" : nil unless layout_.present? # layout for categories for all post types
      r = {category: @category, layout: layout_, render: r_file}; hooks_run("on_render_category", r)
      render r[:render], (!r[:layout].nil? ? {layout: r[:layout]} : {})
    end


    private


    def post_path_exist?
      request_url = request.url.split("?").first
      @post.the_urls.map{|url| url.last}.include?(request_url) || params[:draft_id].present?
    end

  end
end


