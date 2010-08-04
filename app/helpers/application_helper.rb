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
end