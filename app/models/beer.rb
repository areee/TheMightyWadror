class Beer < ActiveRecord::Base
  belongs_to :brewery
  has_many :ratings

  def average_rating

    sum = 0
    # self.ratings.all.each do |r|
    #   sum += r.score
    # end

    self.ratings.map { |r| sum+=r.score}

    count = self.ratings.count.to_f
    average = sum/count

  "Has #{self.ratings.count} ratings, average #{average}" #self.ratings.average(:score) suoraan toimisi myös
  end

end

