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
require 'rails_helper'

RSpec.describe Firm, type: :model do
  it 'validates attributes' do
    building = create :building
    firm = build :firm, building: building.reload

    expect(firm.valid?).to be true
  end
end
