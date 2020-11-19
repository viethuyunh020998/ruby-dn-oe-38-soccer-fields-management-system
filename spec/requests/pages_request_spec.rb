require 'rails_helper'

RSpec.describe "Pages", type: :request do

  describe "GET /search" do
    it "returns http success" do
      get "/pages/search"
      expect(response).to have_http_status(:success)
    end
  end

end
