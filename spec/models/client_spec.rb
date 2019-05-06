require "rails_helper"

RSpec.describe Client, type: :model do
  describe "#office address" do
    it "returns the right address fields" do
      client = create :client, office_choice: "Fairbanks District Office"
      expect(client.office_address).to include(
        name: "Fairbanks District Office",
        address_line1: "675 7th Avenue",
        address_line2: "Station E",
        address_city: "Fairbanks",
        address_state: "AK",
        address_zip: "99701"
      )

      client = create :client, office_choice: "Kodiak District Office"
      expect(client.office_address).to match a_hash_including(
        name: "Kodiak District Office",
        address_line1: "211 Mission Road",
        address_line2: "Suite 101",
        address_city: "Kodiak",
        address_state: "AK",
        address_zip: "99615"
      )
    end

    it "raises when given a bad office name" do
      client = create :client, office_choice: "Whatever"
      expect{client.office_address}.to raise_error "Invalid Office"
    end
  end
end
