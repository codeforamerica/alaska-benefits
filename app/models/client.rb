# == Schema Information
#
# Table name: clients
#
#  id            :bigint           not null, primary key
#  email         :string
#  email_opt_in  :boolean          default(FALSE)
#  mailed        :boolean          default(FALSE)
#  office_choice :string
#  phone         :string
#  text_opt_in   :boolean          default(FALSE)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Client < ApplicationRecord
  has_one_attached :document
  has_one :feedback

  validates :phone, ten_digit_phone_number: true, allow_blank: true
  validate :file_required
  validate :must_opt_in_to_one

  def file_required
    errors.add(:document, "Must choose a file") unless document.attached?
  end

  def must_opt_in_to_one
    if !text_opt_in && !email_opt_in
      errors.add(:must_opt_in_to_one, "Please choose one")
    end

    validates_presence_of :phone, message: "Please add your phone number" if text_opt_in
    validates_presence_of :email, message: "Please add your email address" if email_opt_in
  end

  def office_address
    case office_choice
    when "Fairbanks District Office"
      {
          name: "Fairbanks District Office",
          address_line1: "675 7th Avenue",
          address_line2: "Station E",
          address_city: "Fairbanks",
          address_state: "AK",
          address_zip: "99701"
      }
    when "Nome District Office"
      {
          name: "Nome District Office",
          address_line1: "214 E. Front Street",
          address_line2: "",
          address_city: "Nome",
          address_state: "AK",
          address_zip: "99762"
      }
    when "Homer District Office"
    {
        name: "Homer District Office",
        address_line1: "3670 Lake Street",
        address_line2: "Suite 200",
        address_city: "Homer",
        address_state: "AK",
        address_zip: "99603"
    }
    when "Kenai Peninsula Job Center"
      {
          name: "Kenai Peninsula Job Center",
          address_line1: "11312 Kenai Spur Hwy",
          address_line2: "Suite 2",
          address_city: "Kenai",
          address_state: "AK",
          address_zip: "99611"
      }
    when "Gambell District Office"
      {
          name: "Gambell District Office",
          address_line1: "400 Gambell Street",
          address_line2: "",
          address_city: "Anchorage",
          address_state: "AK",
          address_zip: "99501"
      }
    when "Muldoon District Office"
      {
          name: "Muldoon District Office",
          address_line1: "1251 Muldoon Road",
          address_line2: "Suite 111B",
          address_city: "Anchorage",
          address_state: "AK",
          address_zip: "99504"
      }
    when "Mat-Su District Office"
      {
          name: "Mat-Su District Office",
          address_line1: "855 W. Commercial Drive",
          address_line2: "",
          address_city: "Wasilla",
          address_state: "AK",
          address_zip: "99654"
      }
    when "Juneau District Office"
      {
          name: "Juneau District Office",
          address_line1: "10002 Glacier Hwy",
          address_line2: "Suite 200",
          address_city: "Juneau",
          address_state: "AK",
          address_zip: "99801"
      }
    when "Ketchikan District Office"
      {
          name: "Ketchikan District Office",
          address_line1: "2030 Sea Level Drive",
          address_line2: "Suite 301",
          address_city: "Ketchikan",
          address_state: "AK",
          address_zip: "99901"
      }
    when "Sitka District Office"
      {
          name: "Sitka District Office",
          address_line1: "304 Lake Street",
          address_line2: "Suite 101",
          address_city: "Sitka",
          address_state: "AK",
          address_zip: "99835"
      }
    when "Kodiak District Office"
      {
          name: "Kodiak District Office",
          address_line1: "211 Mission Road",
          address_line2: "Suite 101",
          address_city: "Kodiak",
          address_state: "AK",
          address_zip: "99615"
      }
    else
      raise "Invalid Office"
    end
  end
end
