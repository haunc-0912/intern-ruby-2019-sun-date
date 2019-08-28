require "rails_helper"

RSpec.describe Notification, type: :model do
  subject { FactoryBot.create :notification }

  context "associations" do
    it { is_expected.to belong_to(:owner).class_name(User.name) }
    it { is_expected.to belong_to(:recipient).class_name(User.name) }
  end
end
