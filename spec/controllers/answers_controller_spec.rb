# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:user) { create(:user) }
  let(:question) { create(:question, author: user) }
  let(:author) { create(:user) }

  describe 'POST #create' do
    context 'Authenticated user' do
      before { login(user) }

      context 'with valid attributes' do
        it 'saves a new answer in the datebase' do
          expect { post :create, params: { question_id: question, author: user, answer: attributes_for(:answer), format: :js } }.to change(question.answers, :count).by(1)
        end

        it 'renders create template' do
          post :create, params: { question_id: question, author_id: user, answer: attributes_for(:answer), format: :js }
          expect(response).to render_template :create
        end
      end

      context 'with invalid attributes' do
        it 'does not save the answer' do
          expect { post :create, params: { question_id: question, author_id: author, answer: attributes_for(:answer, :invalid) }, format: :js }.not_to change(Answer, :count)
        end

        it 'renders create template' do
          post :create, params: { question_id: question, author_id: user, answer: attributes_for(:answer, :invalid), format: :js }
          expect(response).to render_template :create
        end
      end
    end

    context 'Unauthenticated user' do
      it "doesn't save the answer" do
        expect { post :create, params: { question_id: question, author: user, answer: attributes_for(:answer) } }.not_to change(question.answers, :count)
      end

      it 'redirects to sign in' do
        post :create, params: { question_id: question, author_id: user, answer: attributes_for(:answer, :invalid) }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'PATCH #update' do
    let!(:answer) { create(:answer, question:, author:) }
    let!(:answers) { create_list(:answer, 3, question:, author:) }

    before { login(user) }

    context 'with valid attributes' do
      it 'changes answer attributes' do
        patch :update, params: { id: answer, answer: { body: 'new body' } }, format: :js
        answer.reload
        expect(answer.body).to eq 'new body'
      end

      it 'renders update view' do
        patch :update, params: { id: answer, answer: { body: 'new body' } }, format: :js
        expect(response).to render_template :update
      end
    end

    context 'with invalid attributes' do
      it 'does not change answer attributes' do
        expect do
          patch :update, params: { id: answer, answer: attributes_for(:answer, :invalid) }, format: :js
        end.not_to change(answer, :body)
      end

      it 'renders update view' do
        patch :update, params: { id: answer, answer: attributes_for(:answer, :invalid) }, format: :js
        expect(response).to render_template :update
      end
    end

    context "Question's author" do
      it 'changes attribute best' do
        patch :update, params: { id: answers[0], answer: { best: true } }, format: :js
        answers[0].reload
        expect(answers[0].best).to be true
        patch :update, params: { id: answers[1], answer: { best: true } }, format: :js
        answers[1].reload
        answers[0].reload

        expect(answers[1].best).to be true
        expect(answers[0].best).to be false
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:answer) { create(:answer, question:, author:) }

    context 'author delete his answer' do
      before { login(author) }

      it 'deletes the answer' do
        expect { delete :destroy, params: { id: answer, question_id: question, author_id: author }, format: :js }.to change(Answer, :count).by(-1)
      end

      context 'tries to delete others answer' do
        before { login(user) }

        it "doesn't delete the answer" do
          expect { delete :destroy, params: { id: answer, question_id: question, author_id: author }, format: :js }.not_to change(Answer, :count)
        end

        it 'renders template destroy' do
          delete :destroy, params: { id: answer, question_id: question, author_id: author }, format: :js
          expect(response).to render_template :destroy
        end
      end
    end
  end
end
