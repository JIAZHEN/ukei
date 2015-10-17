class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :load_categories
  before_action :load_logo

  def page_contents(*names)
    contents = PageContent.where("name IN (?)", names).all
    contents.each { |content| instance_variable_set("@#{content.name}", content) }
  end

  def load_categories
    @categories = Category.where(:parent_id => nil).order(:id => :asc).all
  end

  def load_logo
    @logo = PageContent.find_by(:name => "logo")
  end
end
