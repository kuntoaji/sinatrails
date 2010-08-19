class Application
  helpers do
    def admin?
      current_user.admin?
    end

    def member?
      current_user.member?
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
