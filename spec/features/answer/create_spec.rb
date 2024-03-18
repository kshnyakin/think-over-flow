require 'rails_helper'

feature 'user can create answer', ' In order to give answer on a question of coominity as '\
  "an authenticated user I'd like to be able to answer on the question" do
  given(:user) { create(:user) }
  given(:answer_text) { 'Ответ на все вопросы'}
  let(:question) { create(:question) }

  describe 'Authenticated user' do
    background do
      sign_in(user)
    end

    scenario 'can create an answer', js: true do
      visit question_path(question)
      fill_in 'Body', with: answer_text
      click_on 'Add answer'

      expect(current_path).to eq(question_path(question))
      within '.answers' do
        expect(page).to have_content(answer_text)
        expect(question.answers.last.body).to eq(answer_text)
      end
    end

    scenario 'asks an answer with errors', js: true do
      visit question_path(question)
      click_on 'Add answer'

      # save_and_open_page  
      # binding.pry
      # пофиксить тут тесты
      expect(page).to have_content("Body не может быть пустым")
    end
  end

  describe 'Unathenticated user' do

    scenario 'can not create an answer an answer' do
      visit question_path(question)

      expect(page).to have_content(
        'Авторизуйтесь, чтобы иметь возможность дать ответ на вопрос'
      )
    end

  end
end
