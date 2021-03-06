class QuestionsController < ApplicationController
  before_action :set_question!, only: %i[show edit update destroy]

  def index
    @pagy, @questions = pagy Question.order(created_at: :desc)
    @questions = @questions.decorate
  end

  def show
    @question = @question.decorate
    # Ищет question по id
    # Инициализируем новый несохранённый answer привязанный к question
    @answer = @question.answers.build
    # Массив со всеми answers сортированный по дате
    @pagy, @answers = pagy @question.answers.order(created_at: :desc), items: 2
    # Массив со всеми answers сортированный по дате 2 способ
    # @answers = Answer.where(question_id: @question.id).order created_at: :desc
    @answers = @answers.decorate
  end

  def new
    # Инициализируем новый несохранённый question
    @question = Question.new
  end

  def create
    # render plain: params - Отображает отправленные данные
    # Сохраняет question в БД
    @question = Question.new question_params
    if @question.save
      flash[:success] = 'Question created!'
      redirect_to questions_path
    else
      render :new
    end
  end

  # Ищет question по id
  def edit; end

  def update
    # Ищет question по id
    # Изменяет question в БД
    if @question.update question_params
      flash[:success] = 'Question update!'
      redirect_to questions_path
    else
      render :edit
    end
  end

  def destroy
    # Ищет question по id
    # Удаляет question из БД
    @question.destroy
    flash[:success] = 'Question deleted!'
    redirect_to questions_path
  end

  private

  # Выдаёт ошибку если не находит question
  def set_question!
    # Ищет question по id
    @question = Question.find params[:id]
  end

  # Фильтрация params для question
  def question_params
    params.require(:question).permit(:title, :body)
  end
end
