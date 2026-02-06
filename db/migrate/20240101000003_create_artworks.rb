class CreateArtworks < ActiveRecord::Migration[7.2]
  def change
    create_table :artworks do |t|
      t.string :title, null: false
      t.text :description
      t.references :artist, null: false, foreign_key: { to_table: :users }
      t.references :category, null: false, foreign_key: true
      t.string :medium
      t.string :dimensions
      t.integer :year
      t.string :slug, null: false
      t.boolean :featured, default: false
      t.integer :status, default: 0, null: false

      t.timestamps
    end

    add_index :artworks, :slug, unique: true
    add_index :artworks, :featured
    add_index :artworks, :status
  end
end
