class DropMedia < ActiveRecord::Migration
  def up
  	drop_table :media
  end

  def down
  	create_table :media do |t|
      t.string :imdb_id
      t.integer :run_time
      t.integer :rating
      t.text :synopsis
      t.string :title

      t.timestamps
    end
  end
end
