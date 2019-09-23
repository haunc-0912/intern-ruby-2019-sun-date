class Reaction < ApplicationRecord
  include PublicActivity::Common

  enum status: {dislike: 0, like: 1, block: 2}

  belongs_to :active_user, class_name: User.name
  belongs_to :passive_user, class_name: User.name

  scope :matches, ->(user) {where active_user_id: user, status: :like, passive_user_id: (where passive_user_id: user_id, status: :like).pluck(:active_user_id)}
  scope :dislike, ->(user) {where active_user_id: user, status: :dislike}
  scope :blocks, ->(user) {where active_user_id: user, status: :block}
end
