require 'rails_helper'

RSpec.describe "Public::Posts", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/public/posts/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/public/posts/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/public/posts/edit"
      expect(response).to have_http_status(:success)
    end
  end

end
