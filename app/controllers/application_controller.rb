require './config/environment'
require 'pry'
class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get '/' do 
    erb :index
  end

  get '/login' do
    if logged_in?
      redirect '/books'
    else
      erb :'users/login'
    end
  end

  post '/login' do
    if params[:username] == "" || params[:password] == ""
      erb :'users/login', locals: {message: "Please enter your username and password."}
    else
      user = User.find_by(username: params[:username])
      if user && user.authenticate(params[:password])
        session[:id] = user.id
        redirect '/books'
      else
        erb :'users/login', locals: {message: "Incorrect username or password."}
      end
    end
  end

  get '/users' do
    @users = User.all
    erb :'/users/all_users'
  end


  get '/logout' do
    if logged_in?
      session.clear
      redirect '/login'
    else
      redirect '/'
    end
  end

  get '/signup' do
    if logged_in?
      redirect '/books'
    else
      erb :'users/create_user'
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      erb :'users/create_user', locals: {message: "Please fill in all fields."}
    else
      user = User.create(username: params[:username], email: params[:email], password: params[:password])
      redirect '/books'
    end
  end

  get '/:slug' do
    @user = User.find_by_slug(params[:slug])
    if @user == current_user
      redirect '/books'
    else
      @current_user = current_user
      erb :'users/show_user'
    end
  end

  helpers do
    def logged_in?
      !!session[:id]
    end

    def current_user
      User.find(session[:id])
    end
  end
end