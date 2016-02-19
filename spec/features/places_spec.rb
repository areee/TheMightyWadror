require 'rails_helper'

describe "Places" do
  it "if one is returned by the API, it is shown on the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
        [Place.new(name: "Oljenkorsi", id: 1)]
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
  end

  it "if several are returned by the API, all is shown on the page" do
    allow(BeermappingApi).to receive(:places_in).with("koskela").and_return(
        [Place.new(name: "Baari 1", id: 1),
         Place.new(name: "Baari 2", id: 2)
        ]
    )

    visit places_path
    fill_in('city', with: 'koskela')
    click_button "Search"

    expect(page).to have_content "Baari 1"
    expect(page).to have_content "Baari 2"
  end

  it "if zero is returned by the API, notice is shown on the page" do
    allow(BeermappingApi).to receive(:places_in).with("ogeli").and_return(
        []
    )

    visit places_path
    fill_in('city', with: 'ogeli')
    click_button "Search"
    sao

    expect(page).to have_content "No locations in ogeli"
  end

end