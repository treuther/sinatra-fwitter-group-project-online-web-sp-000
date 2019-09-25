class UsersController < ApplicationController

  get '/signup' do
    binding.pry
    if !logged_in?
      erb :'/users/create_user'
    else
      redirect :'/tweets'
    end
  end

  post '/signup' do
    binding.pry
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect :'/signup'
    else
      @user = User.create(params)
      session[:user_id] = @user.id #:user_id is a session key. @user.id is assigning the session key to the user's id that is in session.

      redirect :'/tweets'
    end
  end

  get '/login' do
    # binding.pry
    if logged_in?
      redirect :'/tweets'
    else
      erb :'users/login'
    end
  end

  post '/login' do
    binding.pry
    @user = User.find_by(username: params[:username])

      if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect :'/tweets'
      else
        redirect :'/login'
      end
  end

  # get '/users/:slug' do
  #   @user = User.find_by_slug(params[:slug])
  #   @user_tweets = []
  #   if current_user = @user
  #     Tweet.all.each do |t|
  #       if t.user_id == current_user.id
  #         @user_tweets << t
  #       end
  #     end
  #   else
  #     redirect '/login'
  #   end
  #   erb :'/users/show'
  # end

  get '/logout' do
    if logged_in?
      session.destroy
      redirect to '/login'
    else
      redirect to '/tweets'
    end
  end

end
