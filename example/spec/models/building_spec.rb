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
require 'rails_helper'

RSpec.describe Building, type: :model do
  it 'validates attributes' do
    building = build :building

    expect(building.valid?).to be true
  end
end
