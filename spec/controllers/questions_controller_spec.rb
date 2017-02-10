require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:question) { create(:question) }

  describe 'GET #index' do 
    let(:questions) { create_list(:question, 2) }

    before { get :index }

    it 'populates an array of all questions' do
      expect(assigns(:questions)).to match_array(questions)
    end

    it 'render :index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    before { get :show, id: question }

    it 'assign request question to @question' do
      expect(assigns(:question)).to eq question
    end

    it 'should assigns new answer for question' do
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it 'render :show view' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    before { get :new }

    it 'assign a new Question to @question' do
      expect(assigns(:question)).to be_a_new(Question)
    end

    it 'render :new view' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    context 'with valid data' do
      it 'save new question in db' do
        expect { post :create, question: attributes_for(:question) }.to change(Question, :count).by(1)
      end

      it 'redirect to show view' do
        post :create, question: attributes_for(:question)
        expect(response).to redirect_to question_path(assigns(:question))
      end
    end

    context 'with invalid data' do
      it 'do not save in db' do
        expect { post :create, question: attributes_for(:ivalid_question) }.to_not change(Question, :count)
      end

      it 'render :new view' do
        post :create, question: attributes_for(:ivalid_question)
        expect(response).to render_template :new
      end
    end
  end
end