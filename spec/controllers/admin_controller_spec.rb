require "rails_helper"

RSpec.describe AdminController do
  describe "downloading pdfs" do
    it "works" do
      sign_in create(:admin)

      client = create :client

      get :pdf, params: { id: client.id }
      expect(response.headers.to_h).to include "Content-Type" => "application/pdf"
    end
  end
end