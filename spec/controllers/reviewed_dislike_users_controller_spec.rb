require "rails_helper"
require "ffaker"

RSpec.describe ReviewedDislikeUsersController, type: :controller do
  context "no login" do
    describe "GET #review_disliked_users" do
      it "should found" do
        get :review_disliked_users
        expect(response).to have_http_status(302)
      end

      it "should redirect login page" do
        get :review_disliked_users
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  context "login success" do
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @user = FactoryBot.create(:user)
      sign_in @user
    end

    describe "GET #review_disliked_users" do
      it "should found" do
        get :review_disliked_users
        expect(response).to have_http_status(200)
      end
    end
  end

  context "login fail" do
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @user = FactoryBot.create(:user)
      sign_in @user.name,'123123'
    end

    describe "GET #review_disliked_users" do
      it "should found" do
        get :review_disliked_users
        expect(response).to have_http_status(302)
      end

      it "should redirect login page" do
        get :review_disliked_users
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
