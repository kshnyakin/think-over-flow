class AnswersController < ApplicationController
  before_action :authenticate_user!, only: %i[create edit]

  def new; end

  def create
    @answer = question.answers.create(answer_params)
  end

  def update
    answer.update(answer_params)
    @question = answer.question
  end

  def destroy
    # binding.pry
    question = answer.question
    if current_user.author_of?(answer)
      answer.destroy
      # redirect_to question_path(question)
    else
      # redirect_to question_path(question), notice: 'Answer can be deleted only by author.'
    end
  end

  private

  def question
    @question ||= Question.find(params[:question_id])
  end

  def answer
    @answer ||= Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:body).merge(author_id: current_user.id)
  end
end
