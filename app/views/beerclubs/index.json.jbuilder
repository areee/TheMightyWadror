json.array!(@clubs) do |beerclub|
  json.extract! beerclub, :id, :name, :city, :founded
  json.url beerclub_url(beerclub, format: :json)
end
