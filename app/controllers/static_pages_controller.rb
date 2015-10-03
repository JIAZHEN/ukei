class StaticPagesController < ApplicationController
  before_action { page_contents("logo", "slogen") }

  def home
  end

  def location
    @area = params[:area]
  end

  def contact

  end
end
