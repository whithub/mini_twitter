class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :screen_name
      t.string :location
      t.string :statuses_count
      t.string :friends_count
      t.string :followers_count
      t.string :uid
      t.string :provider
      t.string :oauth_token
      t.string :oauth_token_secret

      t.timestamps null: false
    end
  end
end
