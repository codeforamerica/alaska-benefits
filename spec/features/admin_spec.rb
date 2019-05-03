require 'rails_helper'

RSpec.feature "Admin", type: :feature do
  scenario "Admins can download client's pdf" do
    admin = create :admin
    login_as admin

    create :client

    visit "/admin"

    expect(page).to have_content "Application Link"
  end
end
