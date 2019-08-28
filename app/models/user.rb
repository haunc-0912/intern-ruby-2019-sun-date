class User < ApplicationRecord
  VALID_EMAIL_REGEX = Settings.validates.valid_email

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

  validates :name, presence: true, length:
  {maximum: Settings.validates.max_name}
  validates :email, presence: true, length:
  {maximum: Settings.validates.max_email}, format:
  {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  validates :address, presence: true, length:
  {maximum: Settings.validates.max_address}
  validates :gender, presence: true
  validates :birthday, presence: true
  validates :company, presence: true, length:
  {maximum: Settings.validates.max_company}
end
