require "rails_helper"

RSpec.describe AdminController do
  describe "#pdf" do
    it "works" do
      sign_in create(:admin)

      client = create :client

      get :pdf, params: { id: client.id }
      expect(response.headers.to_h).to include "Content-Type" => "application/pdf"
    end
  end

  describe "#mail_pdf" do
    it "works" do

      lob_mock = instance_double(Lob::Client)
      allow(Lob::Client).to receive(:new).and_return(lob_mock)
      allow(lob_mock).to receive_message_chain(:letters, :create).and_return 200

      sign_in create(:admin)
      client = create :client
      
      post :mail_pdf, params: { id: client.id }, format: 'js'

      expect(lob_mock).to have_received(:letters)
      expect(response).to have_http_status(:success)
      expect(response).to redirect_to "/admin"
    end
  end
end