class Place
  include ActiveModel::Model
  attr_accessor :id, :name, :status, :reviewlink, :proxylink, :blogmap, :street, :city, :state, :zip, :country, :phone, :overall, :imagecount

  def self.rendered_fields
    [:id, :name, :status, :street, :city, :zip, :country, :overall]
  end

  # the next lines are not necessary?
  def self.name
    [:name]
  end

  def self.street
    [:street]
  end

  def self.city
    [:city]
  end

  def self.zip
    [:zip]
  end

  def self.blogmap
    [:blogmap]
  end


end