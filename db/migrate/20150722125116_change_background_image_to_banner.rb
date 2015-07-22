class ChangeBackgroundImageToBanner < ActiveRecord::Migration
  def change
    remove_column :users, :profile_background_image_url, :string
    add_column :users, :profile_banner_url, :string
  end
end
