class Application
  helpers do
    def admin?
      current_user.admin?
    end

    # source: http://sinatra-book.gittr.com/#implemention_of_rails_style_partials
    def partial(page, format="haml", options={})
      if format == "haml"
        haml page, options.merge!(:layout => false)
      elsif format == "erb"
        erb page, options.merge!(:layout => false)
      end
    end

    def paginate(resources)
      html = String.new

      if !resources.next_page.nil? and !resources.previous_page.nil?
        html = "<p>"
        html += "<a href='#{request.path_info}?page=#{resources.previous_page}'>Prev</a> "
        html += "#{params[:page]} of #{resources.total_pages} "
        html += "<a href='#{request.path_info}?page=#{resources.next_page}'>Next</a>"
        html += "</p>"
      elsif !resources.next_page.nil? and resources.previous_page.nil?
        html = "<p>"
        html += "<a href='#{request.path_info}?page=#{resources.next_page}'>Next</a>"
        html += "</p>"
      elsif resources.next_page.nil? and !resources.previous_page.nil?
        html = "<p>"
        html += "<a href='#{request.path_info}?page=#{resources.previous_page}'>Prev</a> "
        html += "#{params[:page]} of #{resources.total_pages}"
        html += "</p>"
      end
      return html
    end
  end
end
