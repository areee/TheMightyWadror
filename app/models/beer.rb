class Beer < ActiveRecord::Base
  belongs_to :brewery
  has_many :ratings

  def average_rating

    sum = 0
    # ratings.each { |num| sum+=num }

    self.ratings.all.each do |r|
      sum += r.score
    end

    count = self.ratings.count.to_f
    average = sum/count

  "Has #{self.ratings.count} ratings, average #{average}" #Rating.average(:score) -> 7.5
  end

end

