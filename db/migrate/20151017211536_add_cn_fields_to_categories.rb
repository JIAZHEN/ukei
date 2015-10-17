class AddCnFieldsToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :name_cn, :string
    add_column :categories, :context_cn, :text
  end
end
