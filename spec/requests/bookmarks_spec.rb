require 'rails_helper'

RSpec.describe "Bookmarks", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/bookmarks/index"
      expect(response).to have_http_status(:success)
    end
  end

end
