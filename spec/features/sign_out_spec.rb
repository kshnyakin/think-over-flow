require 'rails_helper'

feature 'user can sign out', "As authenticated user I'd like to be able to sign out" do
  given(:user) { FactoryBot.create(:user) }
  background do
    sign_in(user)
    visit questions_path
  end

  scenario 'sign out from questions list page' do
    click_on 'Logout'
    expect(page).to have_content 'Выход из системы выполнен'
  end
end
