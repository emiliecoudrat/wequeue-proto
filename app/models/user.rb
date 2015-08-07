# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  first_name             :string
#  last_name              :string
#  birthday               :date
#  city                   :string
#  provider               :string
#  uid                    :string
#  picture                :string
#  name                   :string
#  token                  :string
#  token_expiry           :datetime
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:facebook]
  has_many :chronos

  def self.find_for_facebook_oauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]  # Fake password for validation
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.city = auth.info.location
      user.birthday = Date.strptime(auth.extra.raw_info.birthday,'%m/%d/%Y')
      user.picture = auth.info.image + "?type=large"
      user.token = auth.credentials.token
      user.token_expiry = Time.at(auth.credentials.expires_at)
    end
  end

  def cumulated_duration_in_seconds
    duration = 0
    chronos.each do |chrono|
      duration += chrono.total_duration if chrono.done?
    end
    duration
  end

  def cumulated_duration_in_string
    "#{(cumulated_duration_in_seconds / 3600) < 10 ? "0" + (cumulated_duration_in_seconds / 3600).to_s : cumulated_duration_in_seconds / 3600}:#{(cumulated_duration_in_seconds % 3600 / 60) < 10 ? "0" + (cumulated_duration_in_seconds % 3600 / 60).to_s : cumulated_duration_in_seconds % 3600 / 60}:#{(cumulated_duration_in_seconds % 3600 / 60 % 60) < 10 ? "0" + (cumulated_duration_in_seconds % 3600 / 60 % 60).to_s : cumulated_duration_in_seconds % 3600 / 60 % 60}"
  end
end
