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
# Indexes
#
#  index_users_on_firm_uuid  (firm_uuid)
#  index_users_on_uuid       (uuid) UNIQUE
#
class User < ApplicationRecord
  belongs_to :firm, foreign_key: :firm_uuid, primary_key: :uuid

  validates :name, :email, :phone, presence: true
end
