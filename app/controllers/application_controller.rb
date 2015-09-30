class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :load_categories
  before_action :load_page_contents

  def load_categories
    @categories = Category.where(:parent_id => nil).all
  end

  def load_page_contents
    page_contents = PageContent.where("name IN (?)", ["logo"]).all
    @logo = page_contents[0]
  end
end
