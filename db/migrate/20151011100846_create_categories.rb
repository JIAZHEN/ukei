class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.text :context
      t.integer :lft
      t.integer :rgt
      t.integer :parent_id

      t.timestamps null: false
    end
    add_index :categories, :name
    add_index :categories, :lft
    add_index :categories, :rgt
    add_index :categories, :parent_id
  end
end
