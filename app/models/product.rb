class Product < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
  has_many :reviews
  validates :description, :title, presence: true
  validates :price, presence: true,
                    format: { with: /\A\d+(?:\.\d{0,2})?\z/ },
                    numericality: { greater_than: 0 }

  def average_rating
    reviews.map(&:rating).inject(0.0) { |sum, el| sum + el } / reviews.size
  end
end
