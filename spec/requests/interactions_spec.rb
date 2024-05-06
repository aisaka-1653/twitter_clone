require 'rails_helper'

RSpec.describe "Interactions", type: :request do
  describe "GET /create" do
    it "returns http success" do
      get "/interactions/create"
      expect(response).to have_http_status(:success)
    end
  end

end
