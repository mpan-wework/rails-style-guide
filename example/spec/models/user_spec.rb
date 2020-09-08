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
require 'rails_helper'

RSpec.describe User, type: :model do
  it 'validates attributes' do
    firm = create :firm
    user = build :user, firm: firm.reload

    expect(user.valid?).to be true
  end
end
