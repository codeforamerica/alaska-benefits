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
          #{check_box(item[:method], "data-follow-up-target": item[:method])}  #{item[:label]}
        </label>
      HTML
    end.join.html_safe

    follow_up_html = collection.map do |item|
      cfa_input_field(
        item[:data_follow_up][:method],
        item[:data_follow_up][:label],
        options: {
          "data-follow-up": item[:method]
        },
        type: item[:data_follow_up].fetch(:type, "text")
      )
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

  def cfa_file_upload(
    method,
    label_text: "",
    desktop_button_text: 'Pick a file from this computer',
    mobile_button_text: 'Take a picture',
    accept: nil
  )
    <<~HTML.html_safe
      <div class="form-group #{error_state(object, method)}">
        <p class="form-question">#{label_text}</p>

        <div class="uploaded-files"></div>

        <div class="file-upload">
          #{file_field(method, class: "file-upload__input", accept: accept)}
          <label class="file-upload__label upload-file-button button is-tablet-hidden--inline ">
            #{desktop_button_text} <i class="button__icon icon-file_upload"></i>
          </label>
          <label class="file-upload__label upload-file-button button is-desktop-hidden--inline ">
            #{mobile_button_text} <i class="button__icon icon-file_upload"></i>
          </label>
        </div>
        <br/>
        #{errors_for(object, method)}
      </div>
    HTML
  end
end