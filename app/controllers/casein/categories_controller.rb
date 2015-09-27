# Scaffolding generated by Casein v5.1.1.5

module Casein
  class CategoriesController < Casein::CaseinController

    ## optional filters for defining usage according to Casein::AdminUser access_levels
    # before_filter :needs_admin, :except => [:action1, :action2]
    # before_filter :needs_admin_or_current_user, :only => [:action1, :action2]

    def index
      @casein_page_title = "Categories"
  		@categories = Category.order(sort_order(:name)).paginate :page => params[:page]
    end

    def show
      @casein_page_title = "View category"
      @category = Category.find params[:id]
      @categories = Category.where("id != ?", params[:id]).all
    end

    def new
      @casein_page_title = "Add a new category"
    	@category = Category.new
      @categories = Category.all
    end

    def create
      @category = Category.new category_params

      if @category.save
        flash[:notice] = "Category created"
        redirect_to casein_categories_path
      else
        flash.now[:warning] = "There were problems when trying to create a new category"
        render :action => :new
      end
    end

    def update
      @casein_page_title = "Update category"

      parent_category = Category.find category_params[:parent_id]
      @category = Category.find params[:id]


      if @category.update_attributes(update_params) && @category.move_to_child_of(parent_category)
        flash[:notice] = "Category has been updated"
        redirect_to casein_categories_path
      else
        flash.now[:warning] = "There were problems when trying to update this category"
        render :action => :show
      end
    end

    def destroy
      @category = Category.find params[:id]

      @category.destroy
      flash[:notice] = "Category has been deleted"
      redirect_to casein_categories_path
    end

    private

      def category_params
        params.require(:category).permit(:name, :lft, :rgt, :parent_id)
      end

      def update_params
        params.require(:category).permit(:name)
      end

  end
end