module ReviewsHelper
  def star_rating(rating)
    return rating if rating.is_a?(String)
    remainder = (5 - rating)
    ('★' * rating) + ('☆' * remainder)
  end
end