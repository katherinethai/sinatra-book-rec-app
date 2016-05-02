class DropGenresTable < ActiveRecord::Migration
  def change
    drop_table :genres
  end
end
