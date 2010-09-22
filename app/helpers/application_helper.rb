class Application
  helpers do
    def current_user
      user = User.find_by_id session["user"]
      return user
    end

    def authorize_user
      unless current_user
        flash[:error] = "You're not authorize view that page"
        redirect "/"
      end
    end

    def authorize_admin
      unless current_user.try(:admin?)
        flash[:error] = "You're not authorize view that page"
        redirect "/"
      end
    end

    def css_link_tag(file, options = {})
      css_path = "/stylesheets/#{file.to_s}.css"
      attributes = Array.new
      options.each do |key, value|
        attributes << "#{key}='#{value}'"
      end
      html_attributes = attributes.join(" ")
      timestamp = File.mtime(File.join(Application.public, css_path)).to_i.to_s

      return "<link rel='stylesheet' href='#{css_path}?#{timestamp}' #{html_attributes} />"
    end

    def js_link_tag(file, options = {})
      js_path = "/javascripts/#{file.to_s}.js"
      attributes = Array.new
      options.each do |key, value|
        attributes << "#{key}='#{value}'"
      end
      html_attributes = attributes.join(" ")
      timestamp = File.mtime(File.join(Application.public, js_path)).to_i.to_s

      return "<script src='#{js_path}?#{timestamp}' #{html_attributes}></script>"
    end

    def admin?
      current_user.try(:admin?)
    end

    def member?
      current_user.try(:member?)
    end

    # source: http://sinatra-book.gittr.com/#implemention_of_rails_style_partials
    # to passing local varible:
    # partial :template, nil, :locals => {:myvar => your_var}
    def partial(page, format = :haml, options = {})
      if format == :erb
        erb page, options.merge!(:layout => false)
      else
        haml page, options.merge!(:layout => false)
      end
    end

    def paginate(resources)
      current_page = params[:page].to_s

      if !resources.next_page.nil? and !resources.previous_page.nil?
        html = "<a href='#{request.path}?#{request.query_string.tr('page=' + current_page, 'page=' + resources.previous_page.to_s)}'>&laquo; Prev</a> "
        html += "<span>#{current_page}</span> of #{resources.total_pages}"
        html += "<a href='#{request.path}?#{request.query_string.tr('page=' + current_page, 'page=' + resources.next_page.to_s)}'>Next &raquo;</a>"
      elsif !resources.next_page.nil? and resources.previous_page.nil?
        if request.query_string.empty?
          html = "<a href='#{request.path}?page=#{resources.next_page}'>Next &raquo;</a>"
        elsif !current_page.empty?
          html = "<a href='#{request.path}?#{request.query_string.tr('page=' + current_page, 'page=' + resources.next_page.to_s)}'>Next &raquo;</a>"
        else
          html = "<a href='#{request.fullpath}&page=#{resources.next_page}'>Next &raquo;</a>"
        end
      elsif resources.next_page.nil? and !resources.previous_page.nil?
        html = "<a href='#{request.path}?#{request.query_string.tr('page=' + current_page, 'page=' + resources.previous_page.to_s)}'>&laquo; Prev</a> "
        html += "#{current_page} of #{resources.total_pages}"
      end
      return html
    end
  end
end
