module ApplicationHelper
  include Pagy::Frontend

  def pagination(obj)
    # raw обработка html разметки
    raw(pagy_bootstrap_nav(obj)) if obj.pages > 1
  end

  def nav_tab(title, url, options = {})
    current_page = options.delete :current_page

    css_class = current_page == title ? 'text-secondary' : 'text-white'

    options[:class] = if options[:class]
                        options[:class] + ' ' + css_class
                      else
                        css_class
                      end

    link_to title, url, options
  end

  def currently_at(current_page)
    # render partial: - отрендерит только partial _menu, без layouts
    render partial: 'shared/menu', locals: { current_page: current_page }
  end

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
