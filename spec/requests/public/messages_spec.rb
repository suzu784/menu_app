require 'rails_helper'

RSpec.describe "Public::Messages", type: :request do
  describe "GET /show" do
    it "returns http success" do
      get "/public/messages/show"
      expect(response).to have_http_status(:success)
    end
  end

end
