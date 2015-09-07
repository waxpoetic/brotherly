class AutocompleteInput < SimpleForm::Inputs::Base
  def input(wrapper_options)
    merged_input_options = merge_wrapper_options(
      input_html_options, wrapper_options
    )
    template.content_tag :span, class: 'autocomplete', itemprop: attribute_name do
      template.concat @builder.hidden_field(attribute_name)
      template.concat @builder.text_field_tag("#{attribute_name}_input", attribute_value, merged_input_options)
    end
  end
end
