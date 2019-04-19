class CustomCfaFormBuilder < Cfa::Styleguide::CfaFormBuilder
  def cfa_checkbox_set_with_follow_up(
    method,
    collection,
    label_text: "",
    help_text: nil,
    optional: false,
    legend_class: "",
    follow_up: nil
  )

    checkbox_html = collection.map do |item|
      <<~HTML.html_safe
        <label class="checkbox">
          #{check_box(item[:method], "follow-up-target": item[:method])}  #{item[:label]}
        </label>
      HTML
    end.join.html_safe

    follow_up_html = collection.map do |item|
      cfa_input_field(item[:follow_up][:method], item[:follow_up][:label], options: { "follow-up": item[:method]} )
    end.join.html_safe

    <<~HTML.html_safe
      <div class="question-with-follow-up">
        <div class="question-with-follow-up__question">
          <fieldset class="input-group form-group#{error_state(object, method)}">
            #{fieldset_label_contents(
              label_text: label_text,
              help_text: help_text,
              legend_class: legend_class,
              optional: optional,
            )}
            #{checkbox_html}
            #{errors_for(object, method)}
          </fieldset>
        </div>
        <div class="question-with-follow-up__follow-up">
          #{follow_up_html}
        </div>
      </div>
    HTML
  end

end