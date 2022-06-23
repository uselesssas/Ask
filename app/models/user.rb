class User < ApplicationRecord
  # Создаём виртуальный атрибут который не попадает в БД
  attr_accessor :old_password

  # validations: false - Отключаем валидации чтобы прописать их вручную
  has_secure_password validations: false

  validate :password_presence
  # Проверка только при обновлении
  validate :correct_old_password, on: :update, if: -> { password.present? }
  # password должен быть равен password_confirmation
  # allow_blank: true - При обновлении профиля не требуеться обновлять пароль
  validates :password, confirmation: true, allow_blank: true, length: { minimum: 8, maximum: 70 }

  validates :email, presence: true, uniqueness: true, 'valid_email_2/email': true

  validate :password_complexity

  private

  def correct_old_password
    return if BCrypt::Password.new(password_digest_was).is_password?(old_password)

    errors.add :old_password, 'is incorrect'
  end

  def password_complexity
    # Regexp extracted from https://stackoverflow.com/questions/19605150/regex-for-password-must-contain-at-least-eight-characters-at-least-one-number-a
    return if password.blank? || password =~ /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,70}$/

    errors.add :password, 'complexity requirement not met. Length should be 8-70 characters and include: 1 uppercase, 1 lowercase, 1 digit and 1 special character'
  end

  def password_presence
    # Если пользователь задал пароль раньше его можно не указывать
    # Если пароля нет, пользователь должен его указать
    errors.add(:password, :blank) unless password_digest.present?
  end
end
