class CreateWatchlists < ActiveRecord::Migration[7.2]
  def change
    create_table :watchlists do |t|
      t.references :user, null: false, foreign_key: true
      t.references :auction, null: false, foreign_key: true

      t.timestamps
    end

    add_index :watchlists, [:user_id, :auction_id], unique: true
  end
end
