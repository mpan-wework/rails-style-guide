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
class Building < ApplicationRecord
  has_many :firms, foreign_key: :building_uuid, primary_key: :uuid

  validates :name, presence: true
end
