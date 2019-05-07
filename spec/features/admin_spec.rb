require 'rails_helper'

RSpec.feature "Admin", type: :feature do
  before do
    login_as create(:admin)
    lob_mock = instance_double(Lob::Client)
    allow(Lob::Client).to receive(:new).and_return(lob_mock)
    allow(lob_mock).to receive_message_chain(:letters, :create).and_return 200
  end

  scenario "Admins can download client's pdf" do
    create :client
    visit "/admin"
    expect(page).to have_content "Application Link"
  end

  scenario "Admins can mail the client's application" do
    create :client
    visit "/admin"
    accept_alert "OKAY" do
      click_on "Mail Application to State"
    end
  end
end
