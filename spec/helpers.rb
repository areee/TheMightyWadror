module Helpers

  def sign_in(credentials)
    visit signin_path
    fill_in('username', with:credentials[:username])
    fill_in('password', with:credentials[:password])
    click_button('Log in')
  end

  def create_all_needed
    let!(:brewery) { FactoryGirl.create :brewery, name: "Koff" }
    let!(:beer1) { FactoryGirl.create :beer, name: "iso 3", brewery: brewery }
    let!(:beer2) { FactoryGirl.create :beer, name: "Karhu", brewery: brewery }
    let!(:user) { FactoryGirl.create :user }
    let!(:user2) { FactoryGirl.create :user, username: "Kaisa" }
  end

end