class Reaction < ApplicationRecord
  include PublicActivity::Common

  enum status: {dislike: 0, like: 1, block: 2}

  belongs_to :active_user, class_name: User.name
  belongs_to :passive_user, class_name: User.name
end
