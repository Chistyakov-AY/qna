# frozen_string_literal: true

class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_question, only: [:show, :edit, :destroy, :update]

  def index
    @questions = Question.all
  end

  def show
    @answer = Answer.new
  end

  def new
    @question = Question.new
  end

  def edit; end

  def create
    @question = current_user.questions.create(question_params)

    if @question.save
      redirect_to questions_path, notice: 'Your question was succesfully created'
    else
      render :new
    end
  end

  def update
    if current_user.author_of?(@question)
      @question.update(question_params)
      redirect_to @question
    else
      render :edit, notice: 'Only author can update this question!'
    end
  end

  def destroy
    if current_user.author_of?(@question)
      @question.destroy
      redirect_to root_path, notice: 'Your question was succesfully destroy!'
    else
      redirect_to question_path(@question), notice: 'Only author can delete this question!'
    end
  end

  private

  def question_params
    params.require(:question).permit(:title, :body)
  end

  def set_question
    @question = Question.find(params[:id])
  end
end
