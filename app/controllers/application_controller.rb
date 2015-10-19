class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :load_categories
  before_action :load_logo
  before_action :set_locale

  CN_LOCALE = "zh-CN"

  def page_contents(*names)
    contents = PageContent.where("name IN (?)", names).all
    contents.each { |content| instance_variable_set("@#{content.name}", content) }
  end

  def load_categories
    @categories = Category.where(:parent_id => nil).order(:id => :asc).all
    @services = @categories.find{|category| category.name == "Services"}
    @sectors = @categories.find{|category| category.name == "Sectors"}
  end

  def load_logo
    @logo = PageContent.find_by(:name => "logo")
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
    @attr_suffix = "_cn" if params[:locale] == CN_LOCALE
  end
end
