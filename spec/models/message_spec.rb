require "rails_helper"

RSpec.describe Message, type: :model do
  subject { FactoryBot.create :message }

  context "validations" do
    describe "sender_id valid" do
      it { is_expected.to validate_presence_of :sender_id }
    end

    describe "receiver_id valid" do
      it { is_expected.to validate_presence_of :receiver_id }
    end
  end

  context "associations" do
    it { is_expected.to belong_to(:sender).class_name(User.name) }
    it { is_expected.to belong_to(:receiver).class_name(User.name) }
  end
end
