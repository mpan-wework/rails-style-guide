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
# Indexes
#
#  index_buildings_on_uuid  (uuid) UNIQUE
#
FactoryBot.define do
  factory :building do
    name { SecureRandom.alphanumeric 16 }
  end
end
