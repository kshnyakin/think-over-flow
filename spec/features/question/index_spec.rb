require 'rails_helper'

feature 'user can view list of questions', "User can view list of questions "\
  "no matter authenticated or not" do
  
  given(:user){FactoryBot.create(:user)}
  given(:questions) do
    [
      FactoryBot.create(:question, title: 'Super question 1', body: 'super_body 1'),
      FactoryBot.create(:question, title: 'Super question 2', body: 'super_body 2'),
      FactoryBot.create(:question, title: 'Super question 3', body: 'super_body 3')
    ]
  end

  background do
    questions
  end
  
  describe 'Unauthenticated user' do
    scenario 'view list of questions' do
      visit questions_path

      expect(page).to have_content('Super question 1')
      expect(page).to have_content('super_body 1')
      expect(page).to have_content('Super question 2')
      expect(page).to have_content('super_body 2')
      expect(page).to have_content('Super question 3')
      expect(page).to have_content('super_body 3')
    end
  end

  describe 'Authenticated user' do

    background do
      sign_in(user)
      questions
    end

    scenario 'view list of questions' do
      visit questions_path

      expect(page).to have_content('Super question 1')
      expect(page).to have_content('super_body 1')
      expect(page).to have_content('Super question 2')
      expect(page).to have_content('super_body 2')
      expect(page).to have_content('Super question 3')
      expect(page).to have_content('super_body 3')
    end
  end

end
