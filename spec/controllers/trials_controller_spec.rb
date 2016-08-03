require 'rails_helper'

describe TrialsController, type: :controller do

  describe "#create" do
    before do
      @stimulus = Stimulus.create(num_zeros: 10)
      @session = Session.create
      session[:completed_stimulus_ids] = []
    end
    it "records a trial" do
      allow(Session).to receive(:find).and_return(@session)
      post :create, trial_params(stim_id: @stimulus.id)
      expect(response.status).to eq(200)
      expect(Trial.count).to eq 1
      expect(Trial.first.response_result).to eq true
      expect(Trial.first.order_appeared).to eq 1
    end

    def trial_params(overrides={})
      {
        trial: {
          stim_id: overrides[:stim_id] || 1,
          response: 10
        }
      }
    end
  end
end
