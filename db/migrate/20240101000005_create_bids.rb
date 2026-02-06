class CreateBids < ActiveRecord::Migration[7.2]
  def change
    create_table :bids do |t|
      t.references :auction, null: false, foreign_key: true
      t.references :bidder, null: false, foreign_key: { to_table: :users }
      t.decimal :amount, precision: 10, scale: 2, null: false

      t.timestamps
    end

    add_index :bids, [:auction_id, :amount]
    add_index :bids, [:auction_id, :created_at]
  end
end
