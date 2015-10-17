class AddCnFieldsToPageContents < ActiveRecord::Migration
  def change
    add_column :page_contents, :context_cn, :text
  end
end
