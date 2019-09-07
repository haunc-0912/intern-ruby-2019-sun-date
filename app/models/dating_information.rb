class DatingInformation < ApplicationRecord
  after_validation :geocode, if: :dating_location_changed?
  enum status: {deactive: 0, active: 1}

  geocoded_by :dating_location
  belongs_to :user

  validates :height, numericality: {greater_than: Settings.zero}, allow_nil: true
  validates :weight, numericality: {greater_than: Settings.zero}, allow_nil: true
  validates :dating_location, presence: true, length: {maximum: Settings.validates.max_location}
  validates :dating_distance, presence: true, numericality: {greater_than: Settings.zero, less_than: Settings.validates.max_distance}
  validates :start_age, presence: true, numericality: {greater_than: Settings.zero, less_than: Settings.validates.max_age}
  validates :end_age, presence: true, numericality: {greater_than: Settings.zero, less_than: Settings.validates.max_age}
  validates :description, length: {maximum: Settings.validates.max_description}
  validate :start_age_cannot_be_greater_than_end_age

  def start_age_cannot_be_greater_than_end_age
    return unless start_age > end_age

    errors.add(:start_age, "start_age can't greater than end_age")
  end
end
