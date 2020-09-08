# == Schema Information
#
# Table name: buildings
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  uuid       :uuid             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :building do
    name { SecureRandom.alphanumeric 16 }
  end
end
