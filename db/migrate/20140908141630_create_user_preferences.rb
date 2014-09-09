class CreateUserPreferences < ActiveRecord::Migration
  def change
    create_table :user_preferences do |t|
    	t.belongs_to :user
    	t.string :imdb_id
    	t.string :view_status

      t.timestamps
    end
  end
end
