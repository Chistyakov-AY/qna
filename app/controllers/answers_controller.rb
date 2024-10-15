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
    @answer.update(answer_params) if !set_best

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
    if answer_params.include?(:best) && question_author?
      @answer.choose_the_best_answer
    end
  end

  def find_answer
    @answer = Answer.find(params[:id])
  end

  def find_question
    @question = Question.find(params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:body, :best)
  end

  def question_author?
    current_user.author_of?(@answer.question)
  end
end
