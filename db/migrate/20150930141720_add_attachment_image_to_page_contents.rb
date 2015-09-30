class AddAttachmentImageToPageContents < ActiveRecord::Migration
  def self.up
    change_table :page_contents do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :page_contents, :image
  end
end
