require 'rails_helper'

include Helpers

describe "Rating" do
  create_all_needed

  before :each do
    sign_in(username: "Pekka", password: "Foobar1")
  end

  it "when given, is registered to the beer and user who is signed in" do
    visit new_rating_path
    select('iso 3', from: 'rating[beer_id]')
    fill_in('rating[score]', with: '15')

    expect {
      click_button "Create Rating"
    }.to change { Rating.count }.from(0).to(1)

    expect(user.ratings.count).to eq(1)
    expect(beer1.ratings.count).to eq(1)
    expect(beer1.average_rating).to eq(15.0)
  end

  describe "with created ratings" do
    let!(:rating1) { FactoryGirl.create :rating, beer: beer1, user: user }
    let!(:rating2) { FactoryGirl.create :rating2, beer: beer2, user: user }
    let!(:rating3) { FactoryGirl.create :rating, beer: beer1, user: user }
    let!(:rating4) { FactoryGirl.create :rating2, beer: beer2, user: user2 }

    it "is listed and sum is calculated in ratings page" do
      visit ratings_path
      expect(page).to have_content 'Number of ratings: 4'
      expect(page).to have_content 'iso 3 10 Pekka'
      expect(page).to have_content 'Karhu 20 Pekka'
      expect(page).to have_content 'iso 3 10 Pekka'
      expect(page).to have_content 'Karhu 20 Kaisa'
    end
  end


end