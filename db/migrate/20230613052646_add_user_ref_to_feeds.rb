class AddUserRefToFeeds < ActiveRecord::Migration[6.1]
  def change
    add_reference :feeds, :user, null: false, foreign_key: true
  end
end
