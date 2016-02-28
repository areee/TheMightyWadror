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
    favorite :style
  end

  def favorite_brewery
    favorite :brewery
  end

  def favorite(category)
    return nil if ratings.empty?

    rated = ratings.map{ |r| r.beer.send(category) }.uniq
    rated.sort_by { |item| -rating_of(category, item) }.first
  end

  def rating_of(category, item)
    ratings_of = ratings.select{ |r| r.beer.send(category)==item }
    ratings_of.map(&:score).inject(&:+) / ratings_of.count.to_f
  end

#  def method_missing(method_name, *args, &block)
#    if method_name =~ /^favorite_/
#      category = method_name[9..-1].to_sym
#      self.favorite category
#    else
#      return super
#    end
#  end

  private

#  def rating_of_style(item)
#    ratings_of = ratings.select { |r| r.beer.style==item }
#    ratings_of.map(&:score).inject(&:+) / ratings_of.count.to_f
#  end

#  def rating_of_brewery(item)
#    ratings_of = ratings.select { |r| r.beer.brewery==item }
#    ratings_of.map(&:score).inject(&:+) / ratings_of.count.to_f
#  end

  def self.top(n)
    # palauta listalta parhaat n kappaletta
    # miten? ks. http://www.ruby-doc.org/core-2.1.0/Array.html
    n = n-1
    User.all.sort_by { |b| (b.average_rating||0) }[0..n]
  end

  

end
