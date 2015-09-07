class AutocompleteInput < SimpleForm::Inputs::Base
  def input(wrapper_options)
    merged_input_options = merge_wrapper_options(
      input_html_options, wrapper_options
    )
    @builder.concat do
      @builder.hidden_field attribute_name
      @builder.text_field_tag "#{attribute_name}_input", merged_input_options
    end
  end

  def input_html_options
    super.merge class: 'autocomplete', itemprop: attribute_name
  end
end
