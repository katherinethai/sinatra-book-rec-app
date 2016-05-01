class Author < ActiveRecord::Base
  include Slugifiable

  has_many :books
end