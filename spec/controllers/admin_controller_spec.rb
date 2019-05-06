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

  describe "mailing pdfs" do
    it "works" do

      lob_spy = instance_double(Lob::Client)
      allow(Lob::Client).to receive(:new).and_return(lob_spy)
      allow(lob_spy).to receive_message_chain(:letters, :create).and_return 200

      sign_in create(:admin)
      client = create :client

      post :mail_pdf, params: { id: client.id }, format: 'js'


      expect(lob_spy).to have_received(:letters)
      expect(response).to have_http_status(:success)
    end
  end
end