class ReviewsController < ApplicationController

  expose(:review) { Review.new }
  expose(:product)
  expose(:category)
  before_action :authenticate_user!

  def edit
  end

  def create
    self.review = Review.new(review_params)
    if review.save
      product.reviews << review
      redirect_to category_product_url(product.category, product), notice: 'Review was successfully created.'
    else
      render action: 'create'
    end
  end

  def destroy
    review.destroy
    redirect_to category_product_url(product.category, product), notice: 'Review was successfully destroyed.'
  end

  private
    def review_params
      params.require(:review).permit(:content, :rating).merge(user: current_user)
    end
end
