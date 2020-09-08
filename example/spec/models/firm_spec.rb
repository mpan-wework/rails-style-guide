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
require 'rails_helper'

RSpec.describe Firm, type: :model do
  it 'validates attributes' do
    building = create :building
    firm = build :firm, building: building.reload

    expect(firm.valid?).to be true
  end
end
