module ErrorHandling
  extend ActiveSupport::Concern

  # Добавляет код в класс где подключен модуль ErrorHandling
  included do
    # обрабатывать ошибку ActiveRecord::RecordNotFound в методе notfound
    rescue_from ActiveRecord::RecordNotFound, with: :notfound

    private

    def notfound(exception)
      logger.warn exception
      render file: 'public/404.html', status: :not_found, layout: false
    end
  end
end
