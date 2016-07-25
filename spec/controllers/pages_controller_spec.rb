require 'rails_helper'

describe PagesController, type: :request do

  describe "GET #introduction" do
    it "returns http success" do
      get '/pages/introduction'
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #instructions" do
    it "returns http success" do
      post '/pages/instructions'
      expect(response).to have_http_status(:success)
    end
  end

end
