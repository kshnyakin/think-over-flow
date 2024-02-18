class AnswersController < ApplicationController
  before_action :authenticate_user!, only: %i[create]

  def new; end

  def create
    @answer = question.answers.build(answer_params)
    if @answer.save
      redirect_to question_path(question), notice: 'Your answer successfully added!'
    else
      render :new
    end
  end

  def destroy
    question = answer.question
    if current_user.author_of?(answer)
      answer.destroy
      redirect_to questions_path(question)
    else
      redirect_to question_path(question), notice: 'Answer can be deleted only by author.'
    end
  end

  private

  def question
    @question ||= Question.find(params[:answer][:question_id])
  end

  def answer
    @question ||= Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:question_id, :body, :author_id)
  end
end
