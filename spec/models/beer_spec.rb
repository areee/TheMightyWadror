require 'rails_helper'

RSpec.describe Beer, type: :model do

  it "is created when a name and a style is set" do
    beer = Beer.create name: "Testiolut", style: "Lager"
    expect(beer).to be_valid
    expect(Beer.count).to eq(1)
  end

  it "isn't created when a name is not set" do
    beer = Beer.create style: "Lager"
    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end

  it "isn't created when a style is not set" do
    beer = Beer.create name: "Testiolut"
    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end

  it "is the only rated if only one rating" do
    beer = FactoryGirl.create(:beer)
    rating = FactoryGirl.create(:rating, beer: beer, user: user)
  end

end
