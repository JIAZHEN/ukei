class StaticPagesController < ApplicationController
  def home
  end

  def location
    @area = params[:area]
  end

  def contact

  end
end
