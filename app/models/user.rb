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

  def to_s
    "#{username}"
  end

  def favorite_beer
  end
end
