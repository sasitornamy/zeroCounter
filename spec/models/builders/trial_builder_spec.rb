require 'rails_helper'

describe TrialBuilder do
  describe '#build' do
    context 'valid params' do
      before do
        @session = ExperimentSession.create(consent_given: true)
      end
      context 'first trial' do
        context 'with correct response' do
          it 'builds a trial' do
            builder = TrialBuilder.new(trial_params(
              experiment_session_id: @session.id
            ))
            trial = builder.build
            expect(trial.response_result).to eq true
            expect(trial.order_appeared).to eq 1
          end
        end
        context 'with incorrect response' do
          it 'builds a trial' do
            @builder = TrialBuilder.new(trial_params(
              experiment_session_id: @session.id,
              response: 9
            ))
            trial = @builder.build
            expect(trial.response_result).to eq false
            expect(trial.order_appeared).to eq 1
          end
        end
      end

      context 'second trial' do
        before do
          Trial.create(experiment_session_id: @session.id, response: 10)
        end
        it 'builds a second trial' do
          builder = TrialBuilder.new(trial_params(
            experiment_session_id: @session.id
          ))
          trial = builder.build
          expect(trial.order_appeared).to eq 2
        end
      end
    end

    context 'invalid params' do
      it 'still builds a trial' do
        builder = TrialBuilder.new(trial_params(
          experiment_session_id: 0,
          stimulus_id: 0
        ))
        trial = builder.build
        expect(trial).not_to be_nil
      end
    end

    def trial_params(overrides={})
      {
        experiment_session_id: overrides[:experiment_session_id] ||
          ExperimentSession.create(consent_given: true).id,
        stimulus_id: Stimulus.create(number_of_zeros: 10).id,
        response: overrides[:response] || 10
      }
    end
  end
end
