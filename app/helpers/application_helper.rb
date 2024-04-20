# frozen_string_literal: true

module ApplicationHelper
  def hidden_field_tag(_name, _value = nil, _options = {})
    raise 'Happiness chainではhidden_field_tagの使用を禁止しています'
  end

  def render_flash_messages(flash)
    flash.map do |type, message|
      content_tag(:p, message, class: "alert alert-#{type == 'notice' ? 'success' : 'danger'} text-center")
    end.join.html_safe
  end
end
