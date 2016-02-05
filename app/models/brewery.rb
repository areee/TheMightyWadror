class Brewery < ActiveRecord::Base
  include RatingAverage

  validates :name, presence: true
  validates :year, numericality: { greater_than_or_equal_to: 1042,
                                   less_than_or_equal_to: 2016,
                                   only_integer: true }
  # validate :year_cannot_be_greater_than_this_year

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

  # def year_cannot_be_greater_than_this_year
  #   if Date.today.year > Time.now.year
  #     reload!
  #   end
  #   validates :year, numericality: { greater_than_or_equal_to: 1042,
  #                                    less_than_or_equal_to: Time.now.year,
  #                                    only_integer: true }
  # end

end