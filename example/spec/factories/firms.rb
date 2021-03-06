# == Schema Information
#
# Table name: firms
#
#  id            :bigint           not null, primary key
#  building_uuid :uuid             not null
#  name          :string           not null
#  uuid          :uuid             not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_firms_on_building_uuid  (building_uuid)
#  index_firms_on_uuid           (uuid) UNIQUE
#
FactoryBot.define do
  factory :firm do
    transient do
      building { create(:building).reload }
    end

    name { SecureRandom.alphanumeric 16 }
    building_uuid { building.uuid }
  end
end
