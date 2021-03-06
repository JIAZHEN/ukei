class PageContent < ActiveRecord::Base
  has_attached_file :image, styles: { medium: "255x123" }, default_url: "missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end
