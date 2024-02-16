require 'rails_helper'

feature 'user can create answer', ' In order to give answer on a question of coominity as '\
  "an authenticated user I'd like to be able to answer on the question" do
  given(:user) { FactoryBot.create(:user) }
  let(:question) { FactoryBot.create(:question) }

  describe 'Authenticated user' do
    # background do
    #   sign_in(user)
    # end

    # scenario 'asks a question' do
    #   visit questions_path
    #   click_on 'Ask question'

    #   fill_in 'Title', with: 'Test question'
    #   fill_in 'Body', with: 'Text text text'
    #   click_on 'Ask'

    #   expect(page).to have_content('Your question successfully created.')
    #   expect(page).to have_content('Test question')
    #   expect(page).to have_content('Text text text')
    # end

    # scenario 'asks a question with errors' do
    #   visit questions_path
    #   click_on 'Ask question'
    #   click_on 'Ask'

    #   expect(page).to have_content("Title не может быть пустым")
    #   expect(page).to have_content("Body не может быть пустым")
    # end
  end

  # scenario 'Unauthenticated user tries to ask a question' do
  #   visit questions_path
  #   click_on 'Ask question'

  #   expect(page).to have_content('Вам необходимо войти в систему или зарегистрироваться.')
  # end
end
