module FormHelper

  def field_validity_css_class(instance, attribute)
    return unless instance.errors.include?(attribute)

    'is-invalid'
  end

  def  catched_errors(instance, attribute)
    return unless instance.errors.include?(attribute)

    content_tag(:div, class: 'invalid-feedback') do
      instance.errors.full_messages_for(attribute).join(', ')
    end
  end
end
