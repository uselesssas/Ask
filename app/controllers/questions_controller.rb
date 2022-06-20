class QuestionsController < ApplicationController
  before_action :set_question!, only: %i[show destroy edit update]

  def index
    # Массив со всеми вопросами
    @questions = Question.all
  end

  # Ищет вопрос по id
  def show; end

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

  # Ищет вопрос по id
  def edit; end

  # Изменяет вопрос в БД
  def update
    if @question.update question_params
      flash[:success] = 'Question update!'
      redirect_to questions_path
    else
      render :edit
    end
  end

  # Удаляет вопрос из БД
  def destroy
    @question.destroy
    flash[:success] = 'Question deleted!'
    redirect_to questions_path
  end

  private

  # Выдаёт ошибку если не находит вопрос
  # Ищет вопрос по id
  def set_question!
    @question = Question.find params[:id]
  end

  # Фильтрация params
  def question_params
    params.require(:question).permit(:title, :body)
  end
end
