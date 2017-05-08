class AddFacebookDataToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :facebook_description, :string
    add_column :events, :ticket_url, :string
    add_column :events, :cover_photo_url, :string
  end
end
