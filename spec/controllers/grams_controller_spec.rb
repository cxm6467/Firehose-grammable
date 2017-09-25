require 'rails_helper'

RSpec.describe GramsController, type: :controller do
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
      user = User.create(
          email:                  'fakeuser@gmail.com',
          password:               'secretPassword',
          password_confirmation:  'secretPassword'
        )
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
      user = User.create(
          email:                  'fakeuser@gmail.com',
          password:               'secretPassword',
          password_confirmation:  'secretPassword'
        )
      sign_in user

      post :create, params: { gram: { message: 'Hello!'}}
      expect(response).to redirect_to root_path

      gram = Gram.last
      expect(gram.message).to eq("Hello!")
      expect(gram.user).to eq(user)
    end

    it "should properly deal with validation errors" do
      
      ## Dummy User
      user = User.create(
          email:                  'fakeuser@gmail.com',
          password:               'secretPassword',
          password_confirmation:  'secretPassword'
        )
      sign_in user

      post :create, params: { gram: { message: ''}}
      expect(response).to have_http_status(:unprocessable_entity)
      expect(Gram.count).to eq 0
    end
  end

end
