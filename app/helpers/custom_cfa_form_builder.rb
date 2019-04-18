class CustomCfaFormBuilder < Cfa::Styleguide::CfaFormBuilder

  def cfa_checkbox_set_with_follow_up(
    method,
    collection,
    label_text: "",
    help_text: nil,
    optional: false,
    legend_class: "",
    first_follow_up: nil,
    second_follow_up: nil
  )
    first_follow_up_html = if first_follow_up
      first_follow_up_id = "#{method}-first-follow-up"
      collection.first[:input_html] = { "data-follow-up" => "##{first_follow_up_id}" }

      <<~HTML.html_safe
        <div class="question-with-follow-up__follow-up" id="#{first_follow_up_id}">
          #{first_follow_up.()}
        </div>
      HTML
    end

    second_follow_up_html = if second_follow_up
      second_follow_up_id = "#{method}-second-follow-up"
      collection.second[:input_html] = { "data-follow-up" => "##{second_follow_up_id}" }

      <<~HTML.html_safe
        <div class="question-with-follow-up__follow-up" id="#{second_follow_up_id}">
          #{second_follow_up.()}
        </div>
      HTML
    end

    checkbox_html = collection.map do |item|
      if item[:input_html]
        <<~HTML.html_safe
          <label class="checkbox">
            #{check_box(item[:method], item[:input_html])} #{item[:label]}
          </label>
        HTML
      else
        <<~HTML.html_safe
          <label class="checkbox">
            #{check_box(item[:method])} #{item[:label]}
          </label>
        HTML
      end
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
        #{[first_follow_up_html, second_follow_up_html].compact.join}
      </div>
    HTML
  end

end