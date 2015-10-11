class CategoriesController < ApplicationController
  before_action { page_contents("logo") }

  def show
    @category = Category.find(params[:id])
  end
end
