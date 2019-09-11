class Image < ApplicationRecord
  belongs_to :user

  mount_uploader :link, ImageUploader
end
