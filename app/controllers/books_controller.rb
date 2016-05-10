require 'pry'
class BooksController < ApplicationController


  post '/books/delete' do
    @book = Book.find_by_id(params[:book_id])
    @user = User.find_by_id(params[:user_id])
    if logged_in? && current_user == @user
      @book.delete
      redirect "/finished"
    else
      redirect '/login'
    end
  end

    post '/books/reject' do
    @book = Book.find_by_id(params[:book_id])
    @user = User.find_by_id(params[:user_id])
    if logged_in? && current_user == @user
      @book.delete
      redirect "/books"
    else
      redirect '/login'
    end
  end

  post '/books/:user_slug' do
    @user = User.find_by_slug(params[:user_slug])
    if !params[:title].empty? && !params[:author].empty? && !params[:genre].empty?
      @book = Book.create(title: params[:title], author: params[:author], genre: params[:genre])
      @book.user = @user
      @book.recommender = current_user
      @book.save
      redirect "/#{@user.slug}"
    else
      redirect "/#{@user.slug}"
    end
  end

  get '/books' do 
    if logged_in?
      @user = current_user
      erb :'books/books'
    else
      redirect '/login'
    end
  end

  post '/books/:id/edit' do
    @book = Book.find(params[:id])
    if !params[:title].empty?
      @book.title = params[:title]
    end
    if !params[:author].empty?
      @book.author = params[:author]
    end
    if !params[:genre].empty?
      @book.genre = params[:genre]
    end
    @book.save
    redirect "/#{@book.user.slug}"
  end

  get '/new' do
    if logged_in?
      @user = User.find_by_id(params[:user_id])
      erb :'books/create_book'
    else
      redirect '/login'
    end
  end


  get '/finished' do
    if logged_in?
      @user = current_user
      erb :'books/finished'
    else
      redirect '/login'
    end
  end

  get '/edit' do
    @book = Book.find(params[:book_id])
    if logged_in? && current_user == @book.recommender
      erb :'books/edit_book'
    else
      redirect '/login'
    end
  end

  post '/books/:id/delete' do 
    @book = Book.find(params[:id])
    @user = User.find_by_id(params[:user_id])
    @recommender = User.find(params[:recommender_id])
    if logged_in? && current_user == @recommender
      @book.delete
      redirect "/#{@user.slug}"
    else
      redirect '/login'
    end
  end

  post '/books/:id/read' do
    @book = Book.find(params[:id])
    @user = User.find(params[:user_id])
    if logged_in? && current_user == @user
      @book.read = true
      @book.save
      redirect '/books'
    else
      redirect '/login'
    end
  end 

  post '/books/:id/unread' do
    @book = Book.find(params[:id])
    @user = User.find_by_id(params[:user_id])
    if logged_in? && current_user == @user
      @book.read = false
      @book.save
      redirect '/finished'
    else
      redirect '/login'
    end
  end

end