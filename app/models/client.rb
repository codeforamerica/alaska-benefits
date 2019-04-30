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
end
