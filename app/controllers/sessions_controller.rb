class SessionsController < Clearance::SessionsController
before_filter :store_last_location, only: [:new, :destroy]

def destroy
  puts "paskaa housuissa  #{session[:return_to]}"
  sign_out
  redirect_to session[:return_to] || root_path
end

private
  def url_after_create
    puts "url_after_create #{session[:return_to]}"
    session[:return_to] || root_path
  end

  def store_last_location
    session[:return_to] = request.referer unless URI(request.referer).path == "/passwords"
  end
end
