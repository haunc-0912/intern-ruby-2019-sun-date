class Image < ApplicationRecord
  belongs_to :user

  validates :alt, presence: true,
  length: {maximum: Settings.validates.max_alt}
  validates :link, presence: true
end
