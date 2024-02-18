require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do

  let(:question) { create(:question ) }
  let(:user) { create(:user) }

  describe 'GET #index' do
    let(:questions) { create_list(:question, 3) }
    before { get :index }

    it 'populates an array of all questuions' do
    expect(assigns(:questions)).to match_array(questions) 
    end

    it 'renders index view' do
    expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    before { get :show, params: { id: question } }

    it 'renders index show' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    let(:user) { create(:user) }
    before { login(user) }
    before { get :new }

    it 'renders new show' do
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    before { login(user) }
    before { get :edit, params: { id: question } }

    it 'renders edit show' do
      expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do
    before { login(user) }

    context 'with valid atrrubites' do
      it 'saves a new question in database' do
        expect do
          post :create, params: {question: attributes_for(:question, author_id: user.id)}
        end.to change(Question, :count).by(1)
      end

      it 'redirect to show view of question' do
        post :create, params: {question: attributes_for(:question, author_id: user.id)}
        expect(response).to redirect_to assigns(:question)
      end
    end

    context 'with invalid atrrubites' do
      it 'does not save a new question in database' do
        expect do
          post :create, params: {question: attributes_for(:question, :invalid)}
        end.to_not change(Question, :count)
      end

      it 'redirect to new view of question' do
        post :create, params: {question: attributes_for(:question, :invalid)}
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    before { login(user) }
    
    context 'with valid atrrubites' do

      it 'assign the requested question to question' do
        patch :update, params: { id: question, question: attributes_for(:question)}
        expect(assigns(:question)).to eq question
      end

      it 'changes question attribute' do
        patch :update, params: { id: question, question: { title: 'new title', body: 'new body'} }
        question.reload
        expect(question.title).to eq('new title')
        expect(question.body).to eq('new body')
      end

      it 'redirect to view of exist question' do
        patch :update, params: { id: question, question: attributes_for(:question)}
        expect(response).to redirect_to question
      end


    end

    context 'with invalid atrrubites' do
      before { patch :update, params: { id: question, question: attributes_for(:question, :invalid) } }

      it 'does not change question in database' do
        question.reload
        expect(question.title).to eq('MyString')
        expect(question.body).to eq('MyText')
      end

      it 're-render edit view' do
        expect(response).to render_template :edit
      end
    end
  end


  describe 'DELETE #destroy' do
    before { login(user) }

    context 'with valid atrrubites' do
      let!(:question) { create(:question, author: user ) }

      it 'delete exist question' do
        expect do
          delete :destroy, params: { id: question}
        end.to change(Question, :count).by(-1)
      end

      it 'redirects to index' do
        delete :destroy, params: { id: question}
        expect(response).to redirect_to questions_path
      end
    end

# Нужно добавить тесты, когда удаление пытается совершить не автор вопроса

  end
end
