require 'rails_helper'

feature 'user can edit his answer', ' In order to edit answer on a question of coominity as '\
  "an authenticated user I'd like to be able to edit the answer" do

  given(:user) { create(:user) }
  given!(:question) { create(:question) }
  given!(:answer) { create(:answer, question: question, author: user)}
  given(:edited_answer_body) { 'some edited answer' }

  scenario 'unauthenticated user can not edit answers' do
    visit question_path(question)

    expect(page).to_not have_link 'Edit'
  end

  describe 'authenticated user' do
    
    scenario 'edits his answer', js: true do
      sign_in(user)
      visit question_path(question)

      click_on 'Edit'
      within '.answers' do
        fill_in 'Your answer', with: edited_answer_body
        click_on 'Save'
        # проверка того, что нет старого ответа на странице
        expect(page).to_not have_content(answer.body)
        # убеждаемся, что мы видим новое тело ответа 
        expect(page).to have_content(edited_answer_body)
        # проверяем то, что после нажатия "сохранить" поле ввода для редактирования ответа - пропадает
        expect(page).to_not have_selector('textaera')
      end
    end

    scenario 'edits his answer with errors' do
    end

    scenario 'tries to edit other users question' do
    end
  end
end

