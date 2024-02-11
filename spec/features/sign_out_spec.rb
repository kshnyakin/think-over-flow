require 'rails_helper'

feature 'user can sign out', "As authenticated user I'd like to be able to sign out" do
  
  given(:user){ FactoryBot.create(:user) }
  background {
    sign_in(user)
    visit questions_path
  }
  
  scenario 'sign out from questions list page' do
    click_on 'Logout'
    save_and_open_page
    expect(page).to have_content 'Выход из системы выполнен'
  end
end
