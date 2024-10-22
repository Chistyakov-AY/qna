# frozen_string_literal: true

class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_question, only: :create
  before_action :find_answer, only: [:destroy, :update]

  def create
    @answer = @question.answers.new(answer_params)
    @answer.author = current_user
    @answer.save
  end

  def update
    @answer.files.attach(params[:answer][:files]) if params[:answer][:files].present?

    @answer.update(update_answer_params) unless set_best

    @question = @answer.question
  end

  def destroy
    if current_user.author_of?(@answer)
      @answer.destroy
      flash[:notice] = 'Your answer was successfully deleted'
    else
      flash[:notice] = "You could'n delete this answer"
    end
  end

  private

  def set_best
    return unless answer_params.include?(:best) && question_author?

    @answer.choose_the_best_answer
  end

  def find_answer
    @answer = Answer.with_attached_files.find(params[:id])
  end

  def find_question
    @question = Question.find(params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:body, :best, files: [])
  end

  def update_answer_params
    params.require(:answer).permit(:body, :best)
  end

  def question_author?
    current_user.author_of?(@answer.question)
  end
end
