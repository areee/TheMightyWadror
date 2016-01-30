module RatingAverage
  extend ActiveSupport::Concern

  def average_rating
    sum = 0
    self.ratings.map { |r| sum+=r.score}
    count = self.ratings.count
    average = sum/count.to_f

    "Has #{count} #{"rating".pluralize(count)}, average #{average}"
  end
end