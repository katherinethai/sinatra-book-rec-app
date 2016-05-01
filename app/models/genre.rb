class Genre < ActiveRecord::Base
  include Slugifiable
  
  has_many :books
end