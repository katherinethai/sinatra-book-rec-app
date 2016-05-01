class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.integer :user_id
      t.integer :author_id
      t.integer :genre_id
    end
  end
end
