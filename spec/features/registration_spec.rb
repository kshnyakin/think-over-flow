require 'rails_helper'

feature 'user can register inside application', "User can pass registation procedure" do

  background do
    visit new_user_registration_path
    fill_in 'Email', with: 'wrong@email.com'
    fill_in 'Пароль', with: '12345678'
  end
  
  scenario 'user tries to register himself' do
    fill_in 'Подтверждение пароля', with: '12345678'
    click_on 'Sign up'

    expect(page).to have_content 'Добро пожаловать! Вы успешно зарегистрировались.'
  end

  scenario 'user cannot pass registration if password is not equal password_confirmation filled' do
    fill_in 'Подтверждение пароля', with: '87654321'
    click_on 'Sign up'

    expect(page).to have_content 'Подтверждение пароля не совпадает со значением поля Пароль'
  end
end
