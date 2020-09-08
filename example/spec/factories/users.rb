# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  email      :string           not null
#  firm_uuid  :string           not null
#  name       :string           not null
#  phone      :string           not null
#  uuid       :uuid             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :user do
    transient do
      firm { create(:firm).reload }
    end

    name { SecureRandom.alphanumeric 16 }
    email { "#{SecureRandom.alphanumeric 6}@#{SecureRandom.alphanumeric 6}" }
    phone { DateTime.now.strftime("%Q").to_i }
    firm_uuid { firm.uuid }
  end
end
