require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  describe "comments#create action" do
    it "should allow users to create comments for grams in the database" do
      gram = FactoryGirl.create(:gram)

      user = FactoryGirl.create(:user)
      sign_in user

      post :create, params: { gram_id: gram.id, comment: {message: "awesome gram"}}
      expect(response).to redirect_to root_path
      expect(gram.comments.length).to eq 1
      expect(gram.comments.first.message).to eq "awesome gram"

    end

    it "should require users to be logged in, in order to comment" do
      gram = FactoryGirl.create(:gram)
      post :create, params: { gram_id: gram.id, comment: {message: "awesome gram"}}
      expect(response).to redirect_to new_user_session_path
    end

    it "should generate 404 message if users try to create a comment for an invalid gram id" do
      user = FactoryGirl.create(:user)
      sign_in user
      post :create, params: { gram_id: "Yoloswag", comment: {message: "awesome gram"}}
      expect(response).to have_http_status :not_found
    end

  end
end
