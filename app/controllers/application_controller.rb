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

  post '/login' do
    if params[:username] == "" || params[:password] == ""
      erb :'users/login', locals: {message: "Please enter your username and password."}
    else
      user = User.find_by(username: params[:username])
      if user && user.authenticate(params[:password])
        session[:id] == user.id
        redirect '/books'
      else
        erb :'users/login', locals: {message: "Incorrect username or password."}
      end
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