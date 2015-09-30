class CreatePageContents < ActiveRecord::Migration
  def change
    create_table :page_contents do |t|
      t.string :name
      t.string :image
      t.text :context

      t.timestamps null: false
    end
    add_index :page_contents, :name
  end
end
