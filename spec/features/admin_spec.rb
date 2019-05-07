require 'rails_helper'

RSpec.feature "Admin", type: :feature do
  before do
    login_as create(:admin)
    create :client
    lob_mock = instance_double(Lob::Client)
    allow(Lob::Client).to receive(:new).and_return(lob_mock)
    allow(lob_mock).to receive_message_chain(:letters, :create).and_return 200
  end

  scenario "Admins can download client's pdf" do
    visit "/admin"
    expect(page).to have_content "Application Link"
  end

  scenario "admin can add a clients address" do
    visit "/admin"
    fill_in "Name", with: "Full Name Example"
    fill_in "Street Address", with: "123 Main St"
    fill_in "City", with: "Anchorage"
    fill_in "State", with: "AK"
    fill_in "Zip Code", with: "12345"
    click_on "Add address"

    expect(page).to have_content "123 Main St"
  end

  scenario "Admins can mail the client's application" do
    visit "/admin"
    fill_in "Name", with: "Full Name Example"
    fill_in "Street Address", with: "123 Main St"
    fill_in "City", with: "Anchorage"
    fill_in "State", with: "AK"
    fill_in "Zip Code", with: "12345"
    click_on "Add address"

    click_on "Mail Application to State"
    expect(page.html).to include 'Mailed <i class="icon-done"></i>'
  end
end
