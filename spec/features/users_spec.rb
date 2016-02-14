require 'rails_helper'

include Helpers

describe "User" do
  let!(:brewery) { FactoryGirl.create :brewery, name: "Koff" }
  let!(:beer1) { FactoryGirl.create :beer, name: "iso 3", brewery: brewery }
  let!(:beer2) { FactoryGirl.create :beer, name: "Karhu", brewery: brewery }
  let!(:user) { FactoryGirl.create :user }
  let!(:user2) { FactoryGirl.create :user, username: "Kaisa" }

  before :each do
    # FactoryGirl.create :user
  end

  describe "who has signed up" do
    it "can signin with right credentials" do
      sign_in(username: "Pekka", password: "Foobar1")

      expect(page).to have_content 'Welcome back!'
      expect(page).to have_content 'Pekka'
    end

    it "is redirected back to signin form if wrong credentials given" do
      sign_in(username: "Pekka", password: "wrong")

      expect(current_path).to eq(signin_path)
      expect(page).to have_content 'Username and/or password mismatch'
    end
  end


  it "when signed up with good credentials, is added to the system" do
    visit signup_path
    fill_in('user_username', with: 'Brian')
    fill_in('user_password', with: 'Secret55')
    fill_in('user_password_confirmation', with: 'Secret55')

    expect {
      click_button('Create User')
    }.to change { User.count }.by(1)
  end

  describe "with created ratings" do
    let!(:rating1) { FactoryGirl.create :rating, beer: beer1, user: user }
    let!(:rating2) { FactoryGirl.create :rating2, beer: beer2, user: user }
    let!(:rating3) { FactoryGirl.create :rating, beer: beer1, user: user }
    let!(:rating4) { FactoryGirl.create :rating2, beer: beer2, user: user2 }

    it "when signed in, ratings are showed in current user's page" do
      sign_in(username: "Pekka", password: "Foobar1")
      visit user_path(user)
      expect(page).to have_content 'Has made 3 ratings, average 13.333333333333334'
      expect(page).to have_content 'iso 3 10 delete'
      expect(page).to have_content 'Karhu 20 delete'
      expect(page).to have_content 'iso 3 10 delete'

    end

  end


end