require 'rails_helper'

RSpec.describe AnswersController, type: :controller do

  let(:question) { FactoryBot.create(:question ) }
  # let(:user) { FactoryBot.create(:user) }

  describe 'POST #create' do

    context 'with valid atrrubites' do
      it 'create new answer for question' do
        expect do
          post :create, params: {question_id: question.id, answer: FactoryBot.attributes_for(:answer, question_id: question.id)}
        end.to change(Answer, :count).by(1)
      end

      it 'redirect to show view of answer' do
        post :create, params: {answer: FactoryBot.attributes_for(:answer, question_id: question.id)}
        expect(response).to redirect_to Answer.last
      end
    end

    context 'with invalid atrrubites' do
      it 'does not save a new answer in database' do
        expect do
          post :create, params: {answer: FactoryBot.attributes_for(:answer, :invalid, question_id: question.id)}
        end.to_not change(Answer, :count)
      end

      it 'redirect to new view of question' do
        post :create, params: {answer: FactoryBot.attributes_for(:answer, :invalid, question_id: question.id)}
        expect(response).to render_template :new
      end
    end
  end
end
