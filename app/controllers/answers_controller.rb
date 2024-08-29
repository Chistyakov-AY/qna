# frozen_string_literal: true

class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_answer, only: :destroy
  before_action :find_question, except: [:show]

  def show; end

  def new
    @answer = Answer.new
  end

  def edit; end

  def create
    @answer = @question.answers.new(answer_params)
    @answer.author = current_user
    if @answer.save
      redirect_to question_path(@question), notice: 'Answer was succesfully created' 
    else
      redirect_to @question, notice: "Body can't be blank"
    end
  end

  def destroy
    if @answer.author == current_user
      @answer.destroy
      redirect_to question_path(@question), notice: 'Your answer successfully destroy!'
    else
      redirect_to question_path(@question), notice: 'Only author can delete this answer!'
    end
  end

  private

  def find_answer
    @answer = Answer.find(params[:id])
  end

  def find_question
    @question = Question.find(params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:body)
  end
end
