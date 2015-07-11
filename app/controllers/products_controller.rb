class ProductsController < ApplicationController
  expose(:category)
  expose(:products)
  expose(:product)
  expose(:review) { Review.new }
  expose_decorated(:reviews, ancestor: :product)
  before_action :authenticate_user!, only: [:edit, :create, :update, :new, :destroy]

  def index
  end

  def show
  end

  def new
  end

  def edit
    unless user_is_owner?(Product.find_by(id: params[:id]))
      flash[:error] = 'You are not allowed to edit this product.'
      redirect_to category_product_url(category, product)
    end
  end

  def create
    self.product = Product.new(product_params)
    self.product.user = current_user
    if product.save
      category.products << product
      flash[:notice] = 'Product was successfully created.'
      redirect_to category_product_url(category, product)
    else
      render action: 'new'
    end
  end

  def update
    if user_is_owner?(product)
      if self.product.update(product_params)
        flash[:notice] = 'Product was successfully created.'
        redirect_to category_product_url(category, product)
      else
        render action: 'edit'
      end
    else
      flash[:error] = 'You are not allowed to edit this product.'
      redirect_to category_product_url(category, product)
    end
  end

  # DELETE /products/1
  def destroy
    product.destroy
    redirect_to category_url(product.category), notice: 'Product was successfully destroyed.'
  end

  private

  def user_is_owner?(product)
    current_user.products.exists?(product)
  end

  def product_params
    params.require(:product).permit(:title, :description, :price, :category_id)
  end
end
