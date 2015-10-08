class PageContent < ActiveRecord::Base
  include Bootsy::Container

  has_attached_file :image, styles: { medium: "200x100" }, default_url: "missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end
