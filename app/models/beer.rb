class Beer < ActiveRecord::Base
  include RatingAverage

  belongs_to :brewery
  has_many :ratings, dependent: :destroy

  # def average_rating
  #
  #   sum = 0
  #   # self.ratings.all.each do |r|
  #   #   sum += r.score
  #   # end
  #
  #   self.ratings.map { |r| sum+=r.score}
  #
  #   count = self.ratings.count
  #   average = sum/count.to_f
  #
  # "Has #{count} #{"rating".pluralize(count)}, average #{average}" #self.ratings.average(:score) suoraan toimisi myös
  # end

  def to_s
    "#{self.name} / #{self.brewery.name}"
  end

end

