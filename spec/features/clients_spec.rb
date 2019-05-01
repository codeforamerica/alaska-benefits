require 'rails_helper'

RSpec.feature "Clients", type: :feature do
  scenario "Client uploads their PDF" do
    visit "/upload"

    # pick a file
    expect(page).to have_text "Upload your filled out PDF application"
    page.attach_file("client[document]", Rails.root.join("spec", "fixtures", "application.pdf"), make_visible: true)
    expect(page).to have_text "application.pdf"
  end

  scenario "Client enters their phone and email" do
    visit "/upload"

    check "Text message"
    fill_in "Phone number", with: "1234567890"

    check "Email"
    fill_in "Email", with: "email@example.com"
  end

  scenario "Client fills out the whole form" do
    visit root_path
    click_on "Get the application"
    click_on "Submit my application"

    page.attach_file("client[document]", Rails.root.join("spec", "fixtures", "application.pdf"), make_visible: true)

    select "Juneau District Office", from: "What is your local Public Assistance Office"

    check "Text message"
    fill_in "Phone number", with: "1234567890"

    check "Email"
    fill_in "Email", with: "email@example.com"

    click_on "Submit my application"

    choose "Bad", allow_label_click: true
    fill_in "feedback_comments", with: "Terrible"
    click_on "Submit"
  end
end
