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

  xscenario "admin can add a clients address" do
    visit "/admin"
  end

  scenario "Admins can mail the client's application" do
    visit "/admin"
    click_on "Mail Application to State"
    expect(page.html).to include 'Mailed <i class="icon-done"></i>'
  end
end
