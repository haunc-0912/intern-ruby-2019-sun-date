class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook, :google_oauth2]

  VALID_EMAIL_REGEX = Settings.validates.valid_email
  USER_PARAMS = [:birthday, :avatar, :address, :company, dating_information_attributes: [:height, :weight, :description]].freeze
  USER_IMAGE_PARAMS = [image_attributes: [:link]].freeze

  enum role: {normal: 0, admin: 1}

  has_many :images, dependent: :destroy
  
  has_many :active_messages, class_name: Message.name,
  foreign_key: "sender_id", dependent: :destroy
  has_many :receivers, through: :active_messages, source: :receiver

  has_many :passive_messages, class_name: Message.name,
  foreign_key: "receiver_id", dependent: :destroy
  has_many :senders, through: :passive_messages, source: :sender

  has_many :active_reactions, class_name: Reaction.name,
  foreign_key: "active_user_id", dependent: :destroy
  has_many :passive_users, through: :active_reactions, source: :passive_user

  has_many :passive_reactions, class_name: Reaction.name,
  foreign_key: "passive_user_id", dependent: :destroy
  has_many :active_users, through: :passive_reactions, source: :active_user

  has_many :active_notifications, class_name: Notification.name,
  foreign_key: "owner_id", dependent: :destroy
  has_many :recipients, through: :active_notifications, source: :recipient

  has_many :passive_notifications, class_name: Notification.name,
  foreign_key: "recipient_id", dependent: :destroy
  has_many :owners, through: :passive_notifications, source: :owner

  has_one :dating_information, dependent: :destroy

  accepts_nested_attributes_for :dating_information
  accepts_nested_attributes_for :images, allow_destroy: true, reject_if: proc { |attributes| attributes["image"].blank? }

  mount_uploader :avatar, ImageUploader

  validates :name, presence: true, length: {maximum: Settings.validates.max_name}, allow_nil: true
  validates :email, presence: true, length: {maximum: Settings.validates.max_email},
            format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}, allow_nil: true
  validates :address, length: {maximum: Settings.validates.max_address}
  validates :company, length: {maximum: Settings.validates.max_company}
  validates :password, presence: true, length: {minimum: Settings.validates.min_pass}, allow_nil: true

  class << self
    def new_with_session params, session
      super.tap do |user|
        if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
          user.email = data["email"] if user.email.blank?
        end
      end
    end

    def from_omniauth auth
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.email = auth.info.email
        user.password = Devise.friendly_token[0,20]
        user.name = auth.info.name
        user.image_sc = auth.info.image
      end
    end
  end
end
