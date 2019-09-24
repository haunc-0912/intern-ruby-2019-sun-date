class DatingInformation < ApplicationRecord
  attr_accessor :current_step
  DATING_INFOR_PARAMS = [dating_information_attributes: [:prefer_gender, :start_age, :end_age, :dating_location, :dating_distance]].freeze
  after_validation :geocode, if: :dating_location_changed?
  enum status: {deactive: 0, active: 1}
  enum prefer_gender: {male: 0, female: 1, both: 2}
  geocoded_by :dating_location
  belongs_to :user

  with_options if: -> {current_step == :set_dating_profile} do
    validates :height, presence: true, numericality: {greater_than: Settings.zero}
    validates :weight, presence: true, numericality: {greater_than: Settings.zero}
    validates :description, presence: true, length: {maximum: Settings.validates.max_description}
  end

  with_options if: -> {current_step == :set_dating_citeria} do
    validates :dating_location, presence: true, length: {maximum: Settings.validates.max_location}
    validates :dating_distance, presence: true, numericality: {greater_than: Settings.zero, less_than: Settings.validates.max_distance}
    validates :start_age, presence: true, numericality: {greater_than: Settings.zero, less_than: Settings.validates.max_age}
    validates :end_age, presence: true, numericality: {greater_than: Settings.zero, less_than: Settings.validates.max_age}
    validate :start_age_cannot_be_greater_than_end_age
  end

  def start_age_cannot_be_greater_than_end_age
    return unless (start_age.present? && end_age.present? && start_age > end_age)

    errors.add(:start_age, "start_age can't greater than end_age")
  end

  def is_no_infor?
    self.attributes.each do |_, val|
      return true if val.blank?
    end
    false
  end
end
