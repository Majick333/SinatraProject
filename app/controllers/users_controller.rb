class UsersController < ApplicationController

get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end

  get '/new' do
    if !logged_in?
      erb :'users/new', locals: {message: "Please sign up before you sign in"}
    else
      redirect to '/lists'
    end
  end

  post '/new' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect to '/new'
    else
      @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect to '/lists'
    end
  end

  get '/login' do
    if !logged_in?
      erb :'users/login'
    else
      redirect to '/lists'
    end
  end

  post '/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to "/lists"
    else
      redirect to '/new'
    end
  end

  get '/logout' do
    if logged_in?
      session.destroy
      redirect to '/'
    else
      redirect to '/lists'
    end
  end
end