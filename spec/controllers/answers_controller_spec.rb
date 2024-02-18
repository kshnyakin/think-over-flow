require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:question) { create(:question) }
  let(:user) { create(:user) }
  let(:valid_attributes) { attributes_for(:answer, question_id: question.id, author_id: user.id) }
  let(:invalid_attributes) { attributes_for(:answer, :invalid, question_id: question.id) }

  describe 'POST #create' do
    before { login(user) }

    context 'with valid atrrubites' do
      it 'create new answer for question' do
        expect do
          post :create, params: {
            question_id: question.id,
            answer: valid_attributes
          }
        end.to change(Answer, :count).by(1)
      end

      it 'redirect to show view of answer' do
        post :create, params: {
          answer: valid_attributes
        }
        expect(response).to redirect_to question
      end
    end

    context 'with invalid atrrubites' do
      it 'does not save a new answer in database' do
        expect do
          post :create, params: { answer: invalid_attributes }
        end.to_not change(Answer, :count)
      end

      it 'redirect to new view of question' do
        post :create, params: { answer: invalid_attributes }
        expect(response).to render_template :new
      end
    end
  en
  
  # Нужны тесты на #DESTROY !!!
end
