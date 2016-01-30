class Brewery < ActiveRecord::Base
  include RatingAverage

  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  def print_report
    puts self.name
    puts "established at year #{self.year}"
    puts "number of beers #{self.beers.count}"
  end

  def restart
    self.year = 2016
    puts "changed year to #{year}"
  end

  # def average_rating
  #
  #   sum = 0
  #   self.ratings.map { |r| sum+=r.score}
  #   count = self.ratings.count
  #   average = sum/count.to_f
  #
  #   "Has #{count} #{"rating".pluralize(count)}, average #{average}"
  # end

end