class Restaurant < ActiveRecord::Base
  has_many :reviews
  validates :name, presence: true, format: {with: /\A[A-Z]/}
  validates :cuisine, presence: true, length: { minimum: 3 }

  def average_rating
    return 'N/A' if reviews.none?
    reviews.average(:rating) # some kind of rails magic. lol
    # reviews.inject(0) { |sum, review| sum + review.rating } / reviews.count.to_f
  end
end