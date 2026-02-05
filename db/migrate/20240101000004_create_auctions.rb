class CreateAuctions < ActiveRecord::Migration[7.2]
  def change
    create_table :auctions do |t|
      t.references :artwork, null: false, foreign_key: true
      t.references :seller, null: false, foreign_key: { to_table: :users }
      t.decimal :starting_price, precision: 10, scale: 2, null: false
      t.decimal :reserve_price, precision: 10, scale: 2
      t.decimal :current_price, precision: 10, scale: 2, null: false
      t.datetime :starts_at, null: false
      t.datetime :ends_at, null: false
      t.integer :status, default: 0, null: false
      t.integer :bids_count, default: 0, null: false

      t.timestamps
    end

    add_index :auctions, :status
    add_index :auctions, :ends_at
    add_index :auctions, :starts_at
  end
end
