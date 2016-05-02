class Book < ActiveRecord::Base
  belongs_to :user

  def recommender
    User.all.find {|user| user.id == self.recommender_id}
  end

  def recommender=(user)
    self.recommender_id = user.id
  end

  def slug
    self.title.gsub(" ","-").downcase
  end

  def self.find_by_slug(slug)
    self.all.find {|instance| instance.slug == slug}
  end
end