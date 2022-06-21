class Answer < ApplicationRecord
  # Связь с таблицей Question 1:М Answer
  belongs_to :question

  validates :body, presence: true, length: { minimum: 2 }

  def formatted_created_at
    created_at.strftime('%Y-%m-%d %H:%M:%S')
  end
end
