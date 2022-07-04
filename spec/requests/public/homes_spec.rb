require 'rails_helper'

RSpec.describe "Public::Homes", type: :request do
  describe "GET /top" do
    it "returns http success" do
      get "/public/homes/top"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /about" do
    it "returns http success" do
      get "/public/homes/about"
      expect(response).to have_http_status(:success)
    end
  end

end
