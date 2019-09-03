class DatingInformation < ApplicationRecord
  enum status: {deactive: 0, active: 1}

  has_one :user

  validates :height, presence: true, numericality:
  {greater_than: Settings.zero}
  validates :weight, presence: true, numericality:
  {greater_than: Settings.zero}
  validates :dating_location, presence: true, length:
  {maximum: Settings.validates.max_location}
  validates :dating_distance, presence: true, numericality:
  {greater_than: Settings.zero, less_than: Settings.validates.max_distance}
  validates :start_age, presence: true, numericality:
  {greater_than: Settings.zero, less_than: Settings.validates.max_age}
  validates :end_age, presence: true, numericality:
  {greater_than: Settings.zero, less_than: Settings.validates.max_age}
  validates :description, presence: true, length:
  {maximum: Settings.validates.max_description}
  validate :start_age_cannot_be_greater_than_end_age

  def start_age_cannot_be_greater_than_end_age
    return unless start_age > end_age

    errors.add(:start_age, "start_age can't greater than end_age")
  end
end
