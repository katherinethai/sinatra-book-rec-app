class Book < ActiveRecord::Base
  include Slugifiable
  
  belongs_to :user
  belongs_to :author
  belongs_to :genre
end