# == Schema Information
#
# Table name: clients
#
#  id            :bigint           not null, primary key
#  email         :string
#  email_opt_in  :boolean          default(FALSE)
#  office_choice :string
#  phone         :string
#  text_opt_in   :boolean          default(FALSE)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

FactoryBot.define do
  factory :client do
    text_opt_in { true }
    phone { "1234567890" }
    office_choice { "Nome District Office" }

    document { fixture_file_upload(Rails.root.join('spec', 'fixtures', 'application.pdf')) }
  end
end
