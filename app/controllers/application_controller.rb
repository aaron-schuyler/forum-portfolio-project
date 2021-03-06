require './config/environment'

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "top_secret"
  end
  get "/" do
    if is_logged_in?
      redirect :'/posts'
    else
      redirect :'/login'
    end
  end
  not_found do
    status 404
    erb :oops
  end
  helpers do
    def alphanumeric?(string)
      !string.match(/\A[a-zA-Z0-9]*\z/).nil?
    end
    def is_logged_in?
      !!session[:user_id]
    end
    def current_user
      User.find_by_id(session[:user_id])
    end
    def belongs_to_current_user(object)
      if current_user
        !!(current_user.id == object.user_id)
      end
    end
  end
end
