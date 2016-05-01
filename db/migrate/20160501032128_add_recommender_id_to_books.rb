class AddRecommenderIdToBooks < ActiveRecord::Migration
  def change
    add_column :books, :recommender_id, :integer
  end
end
