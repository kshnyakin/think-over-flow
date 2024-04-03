require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:question) { create(:question) }
  let(:user) { create(:user) }
  let(:user_not_author) { create(:user) }
  let(:valid_attributes) { attributes_for(:answer) }
  let(:invalid_attributes) { attributes_for(:answer, :invalid) }

  describe 'POST #create' do
    before { login(user) }

    context 'with valid atrrubites' do
      it 'create new answer for question' do
        expect do
          post :create, params: {
            answer: valid_attributes,
            question_id: question.id,
            format: :js
          }
        end.to change(Answer, :count).by(1)
      end

      it 'redirect to question show with answer' do
        post :create, params: {
          answer: valid_attributes,
          question_id: question.id,
          format: :js
        }
        expect(response).to render_template :create
      end
    end

    context 'with invalid atrrubites' do
      it 'does not save a new answer in database' do
        expect do
          post :create, params: {
            answer: invalid_attributes,
            question_id: question.id,
            format: :js
          }
        end.to_not change(Answer, :count)
      end

      it 'redirect to new view of question' do
        post :create, params: {
          answer: invalid_attributes,
          question_id: question.id,
          format: :js
        }
        expect(response).to render_template :create
      end
    end
  end
  
  describe 'DELETE #destroy' do
    let!(:answer) { create(:answer, author: user, body: 'check text' ) }

    context 'when user is an author of an answer' do
      before { login(user) }
      
      it 'delete exist answer' do
        expect do
          delete :destroy, params: { id: answer.id}
        end.to change(Answer, :count).by(-1)
      end

      it 'redirects to questions index' do
        delete :destroy, params: { id: answer.id}
        expect(response).to redirect_to question_path(answer.question)
      end
    end

    context 'when user is NOT an author of question' do
      before { login(user_not_author) }

      it 'not delete exist question' do
        expect do
          delete :destroy, params: { id: answer.id}
        end.not_to change(Answer, :count).from(1)
      end

      it 'redirect to question page' do
        delete :destroy, params: { id: answer.id}
        expect(response).to redirect_to question_path(answer.question)
      end
    end
  end
end
