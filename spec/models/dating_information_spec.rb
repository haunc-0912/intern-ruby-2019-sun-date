require "rails_helper"

RSpec.describe DatingInformation, type: :model do
  subject { FactoryBot.create :dating_information }

  context "validations" do
    describe "height valid" do
      it { is_expected.to validate_presence_of :height }
      it { is_expected.to validate_numericality_of(:height).is_greater_than Settings.zero }
    end

    describe "weight valid" do
      it { is_expected.to validate_presence_of :weight }
      it { is_expected.to validate_numericality_of(:weight).is_greater_than Settings.zero }
    end

    describe "dating_location valid" do
      it { is_expected.to validate_presence_of :dating_location }
      it { is_expected.to validate_length_of(:dating_location).is_at_most Settings.validates.max_address }
    end

    describe "dating_distance valid" do
      it { is_expected.to validate_presence_of :dating_distance }
      it { is_expected.to validate_numericality_of(:dating_distance).is_greater_than Settings.zero }
      it { is_expected.to validate_numericality_of(:dating_distance).is_less_than Settings.validates.max_distance }
    end

    describe "start_age valid" do
      it { is_expected.to validate_presence_of :start_age }
      it { is_expected.to validate_numericality_of(:start_age).is_greater_than Settings.zero }
      it { is_expected.to validate_numericality_of(:start_age).is_less_than Settings.validates.max_age }
    end

    describe "end_age valid" do
      it { is_expected.to validate_presence_of :end_age }
      it { is_expected.to validate_numericality_of(:end_age).is_greater_than Settings.zero }
      it { is_expected.to validate_numericality_of(:end_age).is_less_than Settings.validates.max_age }
    end

    describe "description valid" do
      it { is_expected.to validate_presence_of(:description) }
      it { is_expected.to validate_length_of(:description).is_at_most Settings.validates.max_description }
    end
  end

  context "associations" do
    it { is_expected.to have_one(:user) }
  end
end
