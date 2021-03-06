class AnswersController < ApplicationController
  # Для работы dom_id
  include ActionView::RecordIdentifier

  before_action :set_question!
  before_action :set_answer!, except: :create

  def create
    # render plain: params - Отображает отправленные данные
    # Ищет question из таблицы Answer по question_id
    # Сохраняет answer в БД
    @answer = @question.answers.build answer_params
    if @answer.save
      flash[:success] = 'Answer created!'
      redirect_to question_path(@question)
    else
      @question = @question.decorate
      # Массив со всеми answers сортированный по дате
      @pagy, @answers = pagy @question.answers.order(created_at: :desc)
      @answers = @answers.decorate
      render 'questions/show'
    end
  end

  # Ищет question из таблицы Answer по question_id
  def edit; end

  def update
    # Ищет question из таблицы Answer по question_id
    # Изменяет answer в БД
    if @answer.update answer_params
      flash[:success] = 'Answer update!'
      redirect_to question_path(@question, anchor: dom_id(@answer))
    else
      render :edit
    end
  end

  def destroy
    # Ищет question из таблицы Answer по question_id
    # Удаляет answer из БД
    @answer.destroy
    flash[:success] = 'Answer deleted!'
    redirect_to question_path(@question)
  end

  private

  # Выдаёт ошибку если не находит question
  def set_question!
    # Ищет question по таблице Answer по question_id
    @question = Question.find params[:question_id]
  end

  def set_answer!
    # Ищет answer из конкретного question по id
    @answer = @question.answers.find params[:id]
  end

  # Фильтрация params для answer
  def answer_params
    params.require(:answer).permit(:body)
  end
end
