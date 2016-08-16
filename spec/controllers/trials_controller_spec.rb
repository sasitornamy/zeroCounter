require 'rails_helper'

describe TrialsController, type: :controller do

  describe '#create' do
    it 'creates a trial' do
      expect{post :create,
      {
        trial: {
          experiment_session_id: ExperimentSession.create(consent_given: true).id,
          stimulus_id: Stimulus.create(number_of_zeros: 10).id,
          response: 10
        },
        trial_start_time: Time.now,
        keystrokes: ''
      }}.to change(Trial, :count).by(1)
      expect(response.status).to eq(200)
    end
  end
end
