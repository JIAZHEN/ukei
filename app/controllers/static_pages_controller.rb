class StaticPagesController < ApplicationController
  def home
    page_contents("slogen", "home_intro")
  end

  def location
    @area = params[:area]
  end

  def contact
  end

  def terms
  end

  def privacy
  end

  def china_desk
  end
end
