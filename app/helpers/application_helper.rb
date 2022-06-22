module ApplicationHelper
  def full_title(page_title)
    base_title = 'ASK'
    # Если значение переменной page_title установлено
    if page_title.present?
      "#{base_title} — #{page_title}"
    else
      base_title
    end
  end
end
