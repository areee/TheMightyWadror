class User < ActiveRecord::Base
  include RatingAverage

  has_secure_password

  validates :username, uniqueness: true, length: { minimum: 3, maximum: 15 }
  validates :password, length: {minimum: 4},
            format: {with: /\A[A-Z]+[\d]+\z/, message: "must include a capital letter AND a digit"}
  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :memberships, dependent: :destroy
  has_many :beerclubs, through: :memberships

  def to_s
    "#{username}"
  end
end
