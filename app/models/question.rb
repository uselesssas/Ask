class Question < ApplicationRecord
  # Связь с таблицей Question 1:М Answer
  has_many :answers, dependent: :destroy

  validates :title, presence: true, length: { minimum: 2 }
  validates :body, presence: true, length: { minimum: 2 }
end
