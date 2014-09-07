class AddIndexToMedia < ActiveRecord::Migration
  def change
  	add_index :media, :imdb_id
  end
end
