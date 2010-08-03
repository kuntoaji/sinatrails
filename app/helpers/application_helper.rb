helpers do
  def current_user
    User.find_by_id session["user"]
  end

  def admin?
    current_user.admin?
  end

  # source: http://sinatra-book.gittr.com/#handling_of_rails_like_nested_params
  def parse_nested_params
    new_params = {}
    params.each_pair do |full_key, value|
      this_param = new_params
      split_keys = full_key.split(/\]\[|\]|\[/)
      split_keys.each_index do |index|
        break if split_keys.length == index + 1
        this_param[split_keys[index]] ||= {}
        this_param = this_param[split_keys[index]]
     end
     this_param[split_keys.last] = value
    end
    request.params.replace new_params
  end

  def authorize_user
    redirect "/" unless current_user
  end

  def authorize_admin
    redirect "/" if current_user && !current_user.admin?
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
