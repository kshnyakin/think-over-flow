require 'rails_helper'

feature 'user can view and create answers from question page',
        'User can view and create answers on question page' do
  given(:user) { create(:user) }
  given(:question) { create(:question, title: 'Super question 1', body: 'super_body 1', author: user) }
  given(:answers) do
    [
      create(:answer, body: 'Do not know!', author: user, question: question),
      create(:answer, body: 'It is easy!', author: user, question: question),
      create(:answer, body: 'Stupid question', author: user, question: question)
    ]
  end

  describe 'Unauthenticated user' do
    describe 'with created answers' do
      background do
        answers
      end
      scenario 'view list of answers on question page' do
        visit question_path(question)
        expect(page).to have_content(answers[0].body)
        expect(page).to have_content(answers[1].body)
        expect(page).to have_content(answers[2].body)
      end

      scenario 'can not add new answer to question on question page' do
        visit question_path(question)
        expect(page).to have_content('Авторизуйтесь, чтобы иметь возможность дать ответ на вопрос')
      end
    end

    describe 'question has no answers' do
      scenario 'view text about answers absent on question page' do
        visit question_path(question)
        expect(page).to have_content('Ответов еще не создано')
      end
    end
  end

  describe 'Authenticated user' do
    background do
      sign_in(user)
    end

    scenario 'can add new answer to question on question page', js: true do
      visit question_path(question)
      fill_in 'Body', with: 'Это же элементарно!'
      click_on 'Add answer'
      expect(page).to have_content('Это же элементарно!')
    end

    scenario 'can add delete question created by himself on questions page' do
      visit questions_path(question)
      click_on 'Удалить вопрос'
      expect(page).to have_content('Вопросы еще не созданы.')
      expect(Question.count).to eq 0
    end
  end
end
