# == Schema Information
#
# Table name: people
#
#  id           :integer          not null, primary key
#  name         :string           not null
#  phone_number :string           not null
#  email        :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  company_id   :integer
#

class Person < ApplicationRecord
  
  belongs_to :company, optional: true

  validates :phone_number, presence: true, format: {
    with: /\A\(?\d{3}\)?[ .-]?\d{3}[ .-]?\d{4}\z/,
    message: "must be a valid phone number format"
  }
end
