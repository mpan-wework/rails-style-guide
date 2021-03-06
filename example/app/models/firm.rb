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
class Firm < ApplicationRecord
  belongs_to :building, foreign_key: :building_uuid, primary_key: :uuid
  has_many :users, foreign_key: :firm_uuid, primary_key: :uuid

  validates :name, presence: true
end
