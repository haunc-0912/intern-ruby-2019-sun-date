class User < ApplicationRecord
  include ApplicationHelper
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook, :google_oauth2]

  VALID_EMAIL_REGEX = Settings.validates.valid_email
  USER_PARAMS = [:gender, :birthday, :avatar, :address, :company, dating_information_attributes: [:height, :weight, :description]].freeze
  USER_IMAGE_PARAMS = [images_attributes: [:link]].freeze

  enum role: {normal: 0, admin: 1}
  enum gender: {male: 0, female: 1, both: 2}

  has_many :messages

  has_many :conversations, foreign_key: :sender_id

  has_many :images, dependent: :destroy

  has_many :active_reactions, class_name: Reaction.name,
  foreign_key: "active_user_id", dependent: :destroy
  has_many :reactings, through: :active_reactions, source: :passive_user

  has_many :passive_reactions, class_name: Reaction.name,
  foreign_key: "passive_user_id", dependent: :destroy
  has_many :reacters, through: :passive_reactions, source: :active_user

  has_many :active_notifications, class_name: Notification.name,
  foreign_key: "owner_id", dependent: :destroy
  has_many :recipients, through: :active_notifications, source: :recipient

  has_many :passive_notifications, class_name: Notification.name,
  foreign_key: "recipient_id", dependent: :destroy
  has_many :owners, through: :passive_notifications, source: :owner

  has_one :dating_information, dependent: :destroy
  accepts_nested_attributes_for :dating_information, update_only: true

  accepts_nested_attributes_for :images, allow_destroy: true, reject_if: proc { |attributes| attributes["link"].blank? }

  mount_uploader :avatar, ImageUploader

  validates :name, presence: true, length: {maximum: Settings.validates.max_name}, allow_nil: true
  validates :email, presence: true, length: {maximum: Settings.validates.max_email},
            format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}, allow_nil: true
  validates :address, length: {maximum: Settings.validates.max_address}
  validates :company, length: {maximum: Settings.validates.max_company}
  validates :password, presence: true, length: {minimum: Settings.validates.min_pass}, allow_nil: true
  validate :age_can_not_be_less_than_18

  scope :by_status_reactings, -> (status){where id: Reaction.where(passive_user_id: self.pluck(:id), status: status).pluck(:passive_user_id)}
  scope :by_status_reacters, -> (status){where id: Reaction.where(active_user_id: self.pluck(:id), status: status).pluck(:active_user_id)}
  scope :by_no_reaction, -> (current_user_id) {where.not id: Reaction.where(active_user_id: current_user_id).pluck(:passive_user_id)}
  scope :active, -> {where id: DatingInformation.active.where(user_id: self.pluck(:id))}
  scope :by_no_block, ->(current_user_id) {where.not id: Reaction.block.where(passive_user_id: current_user_id).pluck(:active_user_id)}
  scope :by_distance, ->(user, distance) {where id: DatingInformation.near(user.dating_information, distance).map(&:user_id)}
  scope :by_age_range, ->(start_age, end_age) {where birthday: end_age.years.ago..start_age.years.ago}
  scope :info_user_match, -> (user){ where id: (Reaction.matches user).pluck(:passive_user_id)}

  scope :by_prefer_gender, ->(gender) do
    send("#{gender}") unless gender == Settings.gender.both
  end

  scope :get_suggest_user, ->(current_user) do
    active.by_prefer_gender(current_user.dating_information.prefer_gender)
      .by_no_reaction(current_user.id).by_no_block(current_user.id)
      .by_age_range(current_user.dating_information.start_age, current_user.dating_information.end_age)
      .by_distance(current_user, current_user.dating_information.dating_distance)
      .where.not id: current_user.id
  end

  scope :info_user_like_me, ->(current_user) do
    current_user.reacters.by_status_reacters(:like).by_no_reaction current_user.id
  end  

  Reaction.statuses.keys.each do |action|
    define_method action do |other_user|
      if react = Reaction.find_by(active_user_id: id, passive_user_id: other_user.id)
        react.update status: "#{action}"
      else
        react = Reaction.create!(
          active_user_id: id,
          passive_user_id: other_user.id,
          status: "#{action}"
        )
      end
      return react
    end
  end

  def is_match? other_user
    active_react = Reaction.find_by active_user_id: id, passive_user_id: other_user.id
    passive_react = Reaction.find_by active_user_id: other_user.id, passive_user_id: id

    return false unless active_react && passive_react
    active_react.status == passive_react.status && active_react.status == Settings.noti_key.like
  end

  class << self
    def info_user_dislike user
      where(id: (Reaction.dislike user).pluck(:passive_user_id)).first
    end

    def info_user_block user
      where(id: (Reaction.blocks user).pluck(:passive_user_id)).first
    end

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

    def ransackable_scopes auth_object = nil
      %i(info_user_match)
    end
  end

  private

  def calculate_age date
    ((Time.zone.now - date.to_time) / 1.year.seconds).floor
  end

  def age_can_not_be_less_than_18
    return unless (birthday.present? &&  (calculate_age birthday) < 18)

    errors.add(:birthday, t("check_age"))
  end
end
