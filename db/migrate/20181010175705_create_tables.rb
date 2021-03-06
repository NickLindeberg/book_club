class CreateTables < ActiveRecord::Migration[5.1]
  def change
    create_table :table do |t|
      t.string :title
      t.text :description
      t.integer :score
      t.references :user, foreign_key: true
      t.references :book, foreign_key: true

      t.timestamps
    end
  end
end
