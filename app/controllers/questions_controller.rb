class QuestionsController < ApplicationController
  def index
    # Массив со всеми вопросами
    @questions = Question.all
  end

  def show
    # Ищет вопрос по id
    @question = Question.find params[:id]
  end

  def new
    # Инициализируем новый объект
    @question = Question.new
  end

  # Создаёт вопрос в БД
  def create
    # render plain: params - Отображает отправленные данные
    @question = Question.new question_params
    if @question.save
      flash[:success] = 'Question created!'
      redirect_to questions_path
    else
      render :new
    end
  end

  private

  # Фильтрация params
  def question_params
    params.require(:question).permit(:title, :body)
  end
end
