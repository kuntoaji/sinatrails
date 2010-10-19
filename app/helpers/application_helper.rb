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
    # to passing local variable:
    # partial :template, nil, :locals => {:myvar => your_var}
    def partial(page, format = :haml, options = {})
      if format == :erb
        erb page, options.merge!(:layout => false)
      else
        haml page, options.merge!(:layout => false)
      end
    end

    # inspired from http://pastie.org/1192729 by krishnaprasad
    def to_params(params_hash)
      new_params = ''
      stack = []

      params_hash.each do |k, v|
        unless k == "page"
          if v.is_a?(Hash)
            stack << [k,v]
          else
            new_params << "#{k}=#{v}&"
          end
        end
      end

      stack.each do |parent, hash|
        hash.each do |k, v|
          unless k == "page"
            if v.is_a?(Hash)
              stack << ["#{parent}[#{k}]", v]
            else
              new_params << "#{parent}[#{k}]=#{v}&"
            end
          end
        end
      end

      new_params.chop! # trailing &
      "&" + new_params unless new_params.empty?
    end

    # inspired from http://pastie.org/1192729 by krishnaprasad
    def paginate(resources)
      parameters = to_params(params.clone)
      
      if !resources.next_page.nil? and !resources.previous_page.nil?
        html = %^<a href="#{request.path_info}?page=#{resources.previous_page}#{parameters}">&laquo; Prev</a> ^
        html += "#{params[:page]} of #{resources.total_pages} "
        html += %^<a href="#{request.path_info}?page=#{resources.next_page}#{parameters}">Next &raquo;</a>^
      elsif !resources.next_page.nil? and resources.previous_page.nil?
        html = %^<a href="#{request.path_info}?page=#{resources.next_page}#{parameters}">Next &raquo;</a>^
      elsif resources.next_page.nil? and !resources.previous_page.nil?
        html = %^<a href="#{request.path_info}?page=#{resources.previous_page}#{parameters}">&laquo; Prev</a> ^
        html += "#{params[:page]} of #{resources.total_pages}"
      end

      html
    end

    def haml(template, options = {}, locals = {})
      Marker.mark("rendering haml #{template}") do
        super(template, options, locals)
      end
    end

    def erb(template, options = {}, locals = {})
      Marker.mark("rendering erb #{template}") do
        super(template, options, locals)
      end
    end
  end
end
