require "rails_helper"

RSpec.describe Image, type: :model do
  subject { FactoryBot.create :image }

  context "validations" do
    describe "alt valid" do
      it { is_expected.to validate_presence_of :alt }
      it { is_expected.to validate_length_of(:alt).is_at_most Settings.validates.max_alt }
    end

    describe "link valid" do
      it { is_expected.to validate_presence_of :link }
    end
  end

  context "associations" do
    it { is_expected.to belong_to(:user) }
  end
end
