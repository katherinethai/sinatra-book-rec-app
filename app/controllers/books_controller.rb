require 'pry'
class BooksController < ApplicationController

  get '/books' do 
    if logged_in?
      @user = current_user
      erb :'books/books'
    else
      redirect '/login'
    end
  end

  get '/books/new' do
    if logged_in?
      @user = User.find(params[:user_id])
      erb :'books/create_book'
    else
      redirect '/login'
    end
  end

  post '/books/:user_slug' do
    @user = User.find(params[:user_id])
    if !params[:title].empty? && !params[:author].empty? && !params[:genre].empty?
      author = Author.where(name: params[:author]).first_or_create
      genre = Genre.create(name: params[:genre])
      @book = Book.create(title: params[:title], author: author, genre: genre, user_id: @user.id)
      @book.recommender = current_user
      @book.save
      erb :'books/books'
    else
      redirect '/books/new'
    end
  end

end