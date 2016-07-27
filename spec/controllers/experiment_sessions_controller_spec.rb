require 'rails_helper'

describe ExperimentSessionsController, type: :request do

  describe "GET #introduction" do
    it "returns http success" do
      get '/experiment_sessions/introduction'
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #instructions" do
    it "returns http success" do
      post '/experiment_sessions/instructions'
      expect(response).to have_http_status(:success)
    end
  end

end
