require 'rails_helper'

include Helpers

describe "Rating" do
  let!(:brewery) { FactoryGirl.create :brewery, name: "Koff" }
  let!(:beer1) { FactoryGirl.create :beer, name: "iso 3", brewery: brewery }
  let!(:beer2) { FactoryGirl.create :beer, name: "Karhu", brewery: brewery }
  let!(:user) { FactoryGirl.create :user }
  let!(:user2) { FactoryGirl.create :user, username: "Kaisa" }

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

    it "is listed and sum is calculated in ratings site" do
      visit ratings_path
      expect(page).to have_content 'Number of ratings: 4'
      expect(page).to have_content 'iso 3 10 Pekka'
      expect(page).to have_content 'Karhu 20 Pekka'
      expect(page).to have_content 'iso 3 10 Pekka'
      expect(page).to have_content 'Karhu 20 Kaisa'
    end

    it "are showed in current user's site" do
      visit user_path(user)
      sao
      expect(page).to have_content 'Has made 3 ratings, average 13.333333333333334'
        expect(page).to have_content 'iso 3 10 delete'
      expect(page).to have_content 'Karhu 20 delete'
      expect(page).to have_content 'iso 3 10 delete'
    end

  end


end