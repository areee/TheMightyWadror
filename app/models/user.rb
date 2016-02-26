class User < ActiveRecord::Base
  include RatingAverage

  validates :username, uniqueness: true,
            length: {minimum: 3, maximum: 15}
  validates :password, length: {minimum: 4},
            format:
                {with: /\d.*[A-Z]|[A-Z].*\d/,
                 message: "has to contain one number and one upper case letter"
                }

  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :memberships
  has_many :beerclubs, through: :memberships

  has_secure_password

  # def to_s
  #   "#{username}"
  # end

  def favorite_beer
    return nil if ratings.empty?
    ratings.order(score: :desc).limit(1).first.beer
  end

  def favorite_style
    return nil if ratings.empty?

    rated = ratings.map { |r| r.beer.style }.uniq
    rated.sort_by { |style| -rating_of_style(style) }.first
  end

  def favorite_brewery
    return nil if ratings.empty?

    rated = ratings.map { |r| r.beer.brewery }.uniq
    rated.sort_by { |brewery| -rating_of_brewery(brewery) }.first
  end

  private

  def rating_of_style(style)
    ratings_of = ratings.select { |r| r.beer.style==style }
    ratings_of.map(&:score).inject(&:+) / ratings_of.count.to_f
  end

  def rating_of_brewery(brewery)
    ratings_of = ratings.select { |r| r.beer.brewery==brewery }
    ratings_of.map(&:score).inject(&:+) / ratings_of.count.to_f
  end

  def self.top(n)
    # palauta listalta parhaat n kappaletta
    # miten? ks. http://www.ruby-doc.org/core-2.1.0/Array.html
    n = n-1
    User.all.sort_by { |b| (b.average_rating||0) }[0..n]
  end

end
