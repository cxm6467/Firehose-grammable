require 'rails_helper'

RSpec.describe GramsController, type: :controller do
  ## Test Update action
  describe "grams#update action" do
    it "should allow users to successfully update grams" do

    end

    it "should have http 404 error if the gram cannot be found" do

    end

    it "should render the edit form with an http status of unprocessable_entity" do

    end
  end
  ## Test edit action
  describe "grams#edit action" do
    it "should successfully show the edit form if the gram is found" do
      gram = FactoryGirl.create(:gram)
      get :edit, params: { id: gram.id }

      expect(response).to have_http_status(:success)
    end

    it "should return a 404 error message if the gram is not found" do
      get :edit, params: {id: 'INVALID_USR'}
      expect(response).to have_http_status(:not_found)
    end
  end

  ## Test for show action in the grams controller
  describe "grams#show action" do
    it "should successfully show the page if the gram is found" do
      gram = FactoryGirl.create(:gram)
      get :show, params: { id: gram.id }
      expect(response).to have_http_status(:success)
    end

    it "should return a 404 error if the gram is not found" do
      get :show, params: { id: 'INVALID_USR'}
      expect(response).to have_http_status(:not_found)
    end
  end

  ## Test for an index action from the Grams Controller
  describe "grams#index action" do
    it "should successfully show the page" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  ## Test for for a new action for the Grams Controller
  describe "grams#new action" do
    it "should require users to be logged in" do
      get :new
      expect(response).to redirect_to new_user_session_path
    end

    it "should successfully show the new form" do
      ## Dummy User
      user = FactoryGirl.create(:user)
      sign_in user

      get :new
      expect(response).to have_http_status(:success)
    end
  end

  ## Test for successful creation of a Gram
  describe "grams#create action" do

    it "should require users to be logged in" do
      post :create, params: { gram: { message: "Hello" } }
      expect(response).to redirect_to new_user_session_path
    end
    it "should successfully create a new gram in our database" do

      ## Dummy User
      user = FactoryGirl.create(:user)
      sign_in user

      post :create, params: { gram: { message: 'Hello!'}}
      expect(response).to redirect_to root_path

      gram = Gram.last
      expect(gram.message).to eq("Hello!")
      expect(gram.user).to eq(user)
    end

    it "should properly deal with validation errors" do

      ## Dummy User
      user = FactoryGirl.create(:user)
      sign_in user

      post :create, params: { gram: { message: ''}}
      expect(response).to have_http_status(:unprocessable_entity)
      expect(Gram.count).to eq 0
    end
  end

end
