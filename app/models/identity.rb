# == Schema Information
#
# Table name: identities
#
#  id         :integer          not null, primary key
#  provider   :string
#  uid        :string
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Identity < ApplicationRecord
  belongs_to :user

  # validation
  validates :provider, :user_id, :uid, presence: true

  def self.find_from_omniauth(auth)
    find_by(provider: auth.provider, uid: auth.uid)
  end

  def self.create_from_omniauth(auth, user)
    Identity.create!(user: user, provider: auth.provider, uid: auth.uid)
  end
end
