class Notification < PublicActivity::Activity
  scope :by_liked, ->(user){where recipient_id: user.id, recipient_type: User.name, trackable_type: Reaction.name, key: Settings.noti_key.like}
  scope :by_match, ->(user){where recipient_id: user.id, recipient_type: User.name, trackable_type: Reaction.name, key: Settings.noti_key.match}
  scope :by_user, ->(user){by_liked(user).or(by_match user).order("created_at DESC")}
end
