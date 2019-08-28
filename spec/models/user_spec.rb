require "rails_helper"

RSpec.describe User, type: :model do
  subject { FactoryBot.create :user }

  describe ".create" do
    it { is_expected.to be_valid }
  end

  context "validations" do
    describe "name valid" do
      it { is_expected.to validate_presence_of :name }
      it { is_expected.to validate_length_of(:name).is_at_most Settings.validates.max_name }
    end

    describe "email valid" do
      it { is_expected.to validate_presence_of :email }
      it { is_expected.to validate_length_of(:email).is_at_most Settings.validates.max_email }
      it { expect(subject.email).to match(Settings.validates.valid_email)  }
      it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
    end

    describe "address valid" do
      it { is_expected.to validate_presence_of :address }
      it { is_expected.to validate_length_of(:address).is_at_most Settings.validates.max_address }
    end

    describe "gender valid" do
      it { is_expected.to validate_presence_of :gender }
    end

    describe "birthday valid" do
      it { is_expected.to validate_presence_of :birthday }
    end

    describe "company valid" do
      it { is_expected.to validate_presence_of(:company) }
      it { is_expected.to validate_length_of(:company).is_at_most Settings.validates.max_company }
    end
  end

  context "associations" do
    it { is_expected.to have_many(:images).dependent :destroy }
    it { is_expected.to have_many(:active_messages).class_name(Message.name).with_foreign_key("sender_id").dependent :destroy }
    it { is_expected.to have_many(:receivers).through(:active_messages).source(:receiver) }

    it { is_expected.to have_many(:passive_messages).class_name(Message.name).with_foreign_key("receiver_id").dependent :destroy }
    it { is_expected.to have_many(:senders).through(:passive_messages).source(:sender) }
	
	  it { is_expected.to have_many(:active_reactions).class_name(Reaction.name).with_foreign_key("active_user_id").dependent :destroy }
    it { is_expected.to have_many(:passive_users).through(:active_reactions).source(:passive_user) }
	
	  it { is_expected.to have_many(:passive_reactions).class_name(Reaction.name).with_foreign_key("passive_user_id").dependent :destroy }
    it { is_expected.to have_many(:active_users).through(:passive_reactions).source(:active_user) }

	  it { is_expected.to have_many(:active_notifications).class_name(Notification.name).with_foreign_key("owner_id").dependent :destroy }
    it { is_expected.to have_many(:recipients).through(:active_notifications).source(:recipient) }

    it { is_expected.to have_many(:passive_notifications).class_name(Notification.name).with_foreign_key("recipient_id").dependent :destroy }
    it { is_expected.to have_many(:owners).through(:passive_notifications).source(:owner) }
  end

  context "indexes" do
    it { is_expected.to have_db_index [:name] }
    it { is_expected.to have_db_index [:email] }
  end
end
