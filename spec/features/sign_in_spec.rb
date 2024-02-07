require 'rails_helper'

feature 'user can sign in', "In order to ask questions As an unauthenticated user I'd like to be able to sign in" do
  
  given(:user){ FactoryBot.create(:user) }
  background { visit new_user_session_path }
  
  scenario 'registered user tries to sign in' do
    
    fill_in 'Email', with: user.email
    fill_in 'Пароль', with: user.password
    click_on 'Log in'
    expect(page).to have_content 'Вход в систему выполнен'
  end

  scenario 'unregistered user tries to sign in' do

    fill_in 'Email', with: 'wrong@email.com'
    fill_in 'Пароль', with: '123456'
    click_on 'Log in'
    expect(page).to have_content 'Неправильный Email или пароль'
  end
end
