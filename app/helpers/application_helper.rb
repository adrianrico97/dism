module ApplicationHelper

  # Xenera elemento para o menú superior da aplicación
  def nav_link(link_text, link_path)
    class_name = current_page?(link_path) ? 'nav-item active' : 'nav-item'

    content_tag(:li, :class => class_name) do
      link_to link_text, link_path, class: 'nav-link'
    end
  end

  # Xenera elemento que mostra a prioridade das issues e aplica un estilo diferente
  # segundo o tipo de prioridade
  def priority_info_html(priority)
    priority_translated = I18n.t("global_constants.issue_priorities.#{priority}")
    class_to_content = case priority
    when ISSUE_PRIORITIES[:low]
      'text-secondary'
    when ISSUE_PRIORITIES[:normal]
      'text-info'
    when ISSUE_PRIORITIES[:high]
      'text-danger'
    end
    content_tag(:small, priority_translated, :class => class_to_content)
  end

  # Devolve a clase para as issues do show de dispositivo
  def class_for_issue_by_state(issue)
    klass = "list-group-item list-group-item-action list-group-item-dark"
    klass << " active" if issue.open? || issue.in_progress?
    klass
  end

  # Xenera un enlace para volver atrás. Debemos pasarlle o enlace ao que debe dirixir
  def go_back_link(link)
    text = content_tag(:span, material_icon.arrow_back) + content_tag(:span, I18n.t('actions.go_back'))
    div_container = content_tag(:div, text, class: 'pl-2 row pr-3')
    link_to(div_container, link, class: 'btn btn-secondary')
  end

end
