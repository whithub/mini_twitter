class AddPhotosToUsers < ActiveRecord::Migration
  def change
    add_column :users, :profile_image_url, :string
    add_column :users, :profile_background_image_url, :string
  end
end
