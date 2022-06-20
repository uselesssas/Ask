class QuestionsController < ApplicationController
  def index
    # Массив со всеми вопросами
    @questions = Question.all
  end
end
