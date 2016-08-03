require 'rails_helper'

describe ExperimentSessionsController, type: :controller do

  describe '#create' do
    it "returns http success" do
      post :create
      expect(response).to have_http_status(:success)
    end
  end

end
