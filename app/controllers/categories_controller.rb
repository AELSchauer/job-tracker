class CategoriesController < ApplicationController

  def index
    @categories = Category.all.order(:title)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      flash[:'success-message'] = "#{@category.title} was created!"
      redirect_to category_path(@category)
    else
      render :new
    end
  end

  def show
    @category = Category.find(params[:id])
  end

  def edit
    @category = Category.new
  end

  def update
    @category = Category.new(category_params)

    if @category.save
      flash[:'success-message'] = "#{@category.title} was updated!"
      redirect_to category_path(@category)
    else
      render :edit
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    flash[:'success-message'] = "#{@category.title} was deleted!"

    redirect_to categories_path
  end

  private

  def category_params
    params.require(:category).permit(:title)
  end
end
