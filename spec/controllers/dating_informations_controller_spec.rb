require "rails_helper"

RSpec.describe DatingInformationsController, type: :controller do

  context "no login" do

    describe "GET #new" do
      it "should found" do
        get :new
        expect(response).to have_http_status(302)
      end

      it "should redirect sign in page" do
        get :new
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "POST #create" do
      it "should found" do
        post :create
        expect(response).to have_http_status(302)
      end
      
      it "should redirect sign in page" do
        post :create
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  context "logined" do
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = FactoryBot.create(:user)
      sign_in user
    end

    describe "GET #new" do
      it "should found" do
        get :new
        expect(response).to have_http_status(200)
      end
    end
  end
end
