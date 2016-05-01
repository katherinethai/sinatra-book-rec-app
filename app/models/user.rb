class User < ActiveRecord::Base
  include Slugifiable
  
  has_many :books
  has_secure_password
end