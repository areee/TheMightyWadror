class BeermappingApi
  def self.places_in(city)
    city = city.downcase
    Rails.cache.fetch(city, expires_in: 1.week) { fetch_places_in(city) }
  end

  private

  def self.fetch_places_in(city)
    # url = "http://beermapping.com/webservice/loccity/#{key}/"
    url = 'http://stark-oasis-9187.herokuapp.com/api/'

    response = HTTParty.get "#{url}#{ERB::Util.url_encode(city)}"
    places = response.parsed_response["bmp_locations"]["location"]

    return [] if places.is_a?(Hash) and places['id'].nil?

    places = [places] if places.is_a?(Hash)
    places.map do |place|
      Place.new(place)
    end
  end

  def self.key
    # "1eb1b16b1f413a5e80312726a6861fc0"
    raise "APIKEY env variable not defined" if ENV['APIKEY'].nil?
    ENV['APIKEY']
  end

  def self.get_place(id)
    # url = "http://beermapping.com/webservice/locquery/#{key}/"
    url = 'http://stark-oasis-9187.herokuapp.com/api/'

    response = HTTParty.get "#{url}/#{id}"
    place = response.parsed_response["bmp_locations"]["location"]

    return nil if place['id'].nil?
    return Place.new(place)
  end

end