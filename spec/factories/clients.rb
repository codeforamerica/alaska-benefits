FactoryBot.define do
  factory :client do
    text_opt_in { true }
    phone { "1234567890" }

    document { fixture_file_upload(Rails.root.join('spec', 'fixtures', 'application.pdf')) }
  end
end