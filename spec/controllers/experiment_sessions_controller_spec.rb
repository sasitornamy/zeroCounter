require 'rails_helper'

describe ExperimentSessionsController, type: :controller do

  describe '#create' do
    context 'valid params' do
      it 'creates an experiment session' do
        expect{post :create,
        {
          experiment_session: {
            consent_given: 1
          }
        }}.to change(ExperimentSession, :count).by(1)
        expect(response.status).to eq(200)
      end
    end
    context 'invalid params' do
      it 'does not create an experiment session' do
        expect{post :create,
        {
          experiment_session: {
            consent_given: 0
          }
        }}.to_not change(ExperimentSession, :count)
        expect(response.status).to eq(200)
      end
    end
  end

end
