module ReviewsHelper
  def star_rating(rating)
    return rating unless rating.respond_to?(:round)
    # return rating if rating.is_a?(String)
    rounded_rating = rating.round
    remainder = (5 - rounded_rating)
    ('★' * rounded_rating) + ('☆' * remainder)
  end
end