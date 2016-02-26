class Beer < ActiveRecord::Base
  include RatingAverage

  validates :name, presence: true
  validates :style, presence: true

  belongs_to :brewery
  belongs_to :style
  has_many :ratings, dependent: :destroy
  has_many :raters, -> { uniq }, through: :ratings, source: :user

  def to_s
    "#{name} #{brewery.name}"
  end

  # def average
  #   return 0 if ratings.empty?
  #   ratings.map{|r| r.score}.sum / ratings.count.to_f
  # end

  def self.top(n)
    # palauta listalta parhaat n kappaletta
    # miten? ks. http://www.ruby-doc.org/core-2.1.0/Array.html
    n = n-1
    Beer.all.sort_by { |b| -(b.average_rating||0) }[0..n]
  end

end

