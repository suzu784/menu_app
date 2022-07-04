require 'rails_helper'

RSpec.describe "Public::Recipes", type: :request do
  describe "GET /show" do
    it "returns http success" do
      get "/public/recipes/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/public/recipes/edit"
      expect(response).to have_http_status(:success)
    end
  end

end
