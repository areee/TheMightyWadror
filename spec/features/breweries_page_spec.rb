require 'rails_helper'

describe "Breweries page" do
  it "should not have any before been created" do
    visit breweries_path
    sao
    expect(page).to have_content 'Listing Breweries'
    expect(page).to have_content 'Number of breweries: 0'
  end
end
