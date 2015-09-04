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
      user.city = auth.info.location if auth.info.location
      user.birthday = Date.strptime(auth.extra.raw_info.birthday,'%m/%d/%Y') if auth.extra.raw_info.birthday
      user.picture = auth.info.image.gsub('http', 'https') + "?type=large"
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
    "#{(cumulated_duration_in_seconds / 3600) < 10 ? "0" + (cumulated_duration_in_seconds / 3600).floor.to_s : (cumulated_duration_in_seconds / 3600).floor}:#{(cumulated_duration_in_seconds % 3600 / 60) < 10 ? "0" + (cumulated_duration_in_seconds % 3600 / 60).floor.to_s : (cumulated_duration_in_seconds % 3600 / 60).floor}:#{((cumulated_duration_in_seconds % 3600 % 60)) < 10 ? "0" + ((cumulated_duration_in_seconds % 3600 % 60)).floor.to_s : ((cumulated_duration_in_seconds % 3600 % 60)).floor}"
  end

  def running_chrono
    Chrono.find_by(user: self, checked_out_at: nil, manually_added_duration_in_minutes: nil)
  end

  def sentence_to_share_cumulated
    "J'ai attendu #{cumulated_duration_in_string} dans des files d'attentes soit #{joke}"
  end

  def joke
    if cumulated_duration_in_seconds / 60 <= 5
      joke = JOKES[0]
    elsif cumulated_duration_in_seconds / 60 <= 10
      joke = JOKES[1]
    elsif cumulated_duration_in_seconds / 60 <= 15
      joke = JOKES[2]
    elsif cumulated_duration_in_seconds / 60 <= 20
      joke = JOKES[3]
    elsif cumulated_duration_in_seconds / 60 <= 25
      joke = JOKES[4]
    elsif cumulated_duration_in_seconds / 60 <= 30
      joke = JOKES[5]
    elsif cumulated_duration_in_seconds / 60 <= 35
      joke = JOKES[6]
    elsif cumulated_duration_in_seconds / 60 <= 40
      joke = JOKES[7]
    elsif cumulated_duration_in_seconds / 60 <= 45
      joke = JOKES[8]
    elsif cumulated_duration_in_seconds / 60 <= 50
      joke = JOKES[9]
    elsif cumulated_duration_in_seconds / 60 <= 55
      joke = JOKES[10]
    elsif cumulated_duration_in_seconds / 60 <= 60
      joke = JOKES[11]
    elsif cumulated_duration_in_seconds / 60 <= 70
      joke = JOKES[12]
    elsif cumulated_duration_in_seconds / 60 <= 80
      joke = JOKES[13]
    elsif cumulated_duration_in_seconds / 60 <= 90
      joke = JOKES[14]
    elsif cumulated_duration_in_seconds / 60 <= 100
      joke = JOKES[15]
    elsif cumulated_duration_in_seconds / 60 <= 110
      joke = JOKES[16]
    elsif cumulated_duration_in_seconds / 60 <= 120
      joke = JOKES[17]
    elsif cumulated_duration_in_seconds / 60 <= 130
      joke = JOKES[18]
    elsif cumulated_duration_in_seconds / 60 <= 140
      joke = JOKES[19]
    else
      joke = JOKES[20]
    end
    joke
  end
end
