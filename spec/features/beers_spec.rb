require 'rails_helper'

include Helpers

describe "Beer" do
  before :each do
    FactoryGirl.create :user
    sign_in(username: "Pekka", password: "Foobar1")
  end

  it "can be added when name is not nul" do
    visit new_beer_path
    fill_in('beer_name', with: 'Testiolut')

    expect {
      click_button "Create Beer"
    }.to change { Beer.count }.from(0).to(1)
  end

  it "is not saved when name is not valid" do
    visit new_beer_path
    click_button "Create Beer"

    expect(page).to have_content '1 error prohibited this beer from being saved:'
    expect(page).to have_content 'Name can\'t be blank'

    expect(Beer.count).to eq(0)

  end

end