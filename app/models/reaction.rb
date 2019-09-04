class Reaction < ApplicationRecord
  include PublicActivity::Common

  enum status: {dislike: 0, like: 1, block: 2}

  belongs_to :active_user, class_name: User.name
  belongs_to :passive_user, class_name: User.name

  scope :active, ->(user_id) {where active_user_id: user_id, status: :like}
  scope :passive, ->(user_id) {where passive_user_id: user_id, status: :like}
  scope :matches, ->(user_id) {where active_user_id: user_id, status: :like, passive_user_id: (where passive_user_id: user_id, status: :like).pluck(:active_user_id)}
end
