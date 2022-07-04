require 'rails_helper'

RSpec.describe "Public::Chats", type: :request do
  describe "GET /show" do
    it "returns http success" do
      get "/public/chats/show"
      expect(response).to have_http_status(:success)
    end
  end

end
