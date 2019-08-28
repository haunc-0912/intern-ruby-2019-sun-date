require "rails_helper"

RSpec.describe Reaction, type: :model do
  subject { FactoryBot.create :reaction }

  context "associations" do
    it { is_expected.to belong_to(:active_user).class_name(User.name) }
    it { is_expected.to belong_to(:passive_user).class_name(User.name) }
  end
end
