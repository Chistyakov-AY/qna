# frozen_string_literal: true

# Comment
class QuestionsController < ApplicationController

  def index
    @questions = Question.all
  end

  def show
    question
  end

  def new
    @question = Question.new
  end

  def edit
    question
  end

  def create
    @question = Question.new(question_params)

    if question.save
      redirect_to @question
    else
      render :new
    end
  end

  def update
    if question.update(question_params)
      redirect_to question
    else
      render :edit
    end
  end

  def destroy
    question.destroy
    redirect_to question_path
  end

  private

  def question_params
    params.require(:question).permit(:title, :body)
  end

  def question
    @question ||= params[:id] ? Question.find(params[:id]) : Question.new
  end
end
