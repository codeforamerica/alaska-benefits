# == Schema Information
#
# Table name: clients
#
#  id             :bigint           not null, primary key
#  city           :string
#  email          :string
#  email_opt_in   :boolean          default(FALSE)
#  mailed         :boolean          default(FALSE)
#  name           :string
#  office_choice  :string
#  phone          :string
#  state          :string
#  street_address :string
#  text_opt_in    :boolean          default(FALSE)
#  zip_code       :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

FactoryBot.define do
  factory :client do
    text_opt_in { true }
    phone { "1234567890" }
    office_choice { "Nome District Office" }

    document { fixture_file_upload(Rails.root.join('spec', 'fixtures', 'application.pdf')) }
  end
end
