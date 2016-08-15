require 'rails_helper'

describe Stimulus do
  describe '#next_remaining' do
    context 'the experiment session exists' do
      before do
        @experiment_session = ExperimentSession.create(consent_given: true)
        @shown_stimulus1 = Stimulus.create
        @shown_stimulus2 = Stimulus.create
        @stimulus3 = Stimulus.create
        allow(ENV).to receive(:[]).with('NUMBER_OF_TRIALS')
          .and_return('3')
      end
      context 'trial has just begun' do
        before do
          @trial_order = nil
        end
        it 'does something' do
          allow_any_instance_of(ExperimentSession).to receive(:stimuli)
            .and_return([])
          stimulus = Stimulus.next_remaining(
            @experiment_session.id,
            @trial_order
          )
          expect(stimulus).not_to be_nil
        end
      end
      context 'trial is in progress' do
        before do
          @trial_order = 2
        end
        it 'returns one of remaining stimuli' do
          allow_any_instance_of(ExperimentSession).to receive(:stimuli)
            .and_return([@shown_stimulus1, @shown_stimulus2])
          stimulus = Stimulus.next_remaining(
            @experiment_session.id,
            @trial_order
          )
          expect(stimulus.id).to eq @stimulus3.id
        end
      end

      context 'trial has end' do
        before do
          @trial_order = 3
        end
        it 'does not return any stimulus' do
          stimulus = Stimulus.next_remaining(
            @experiment_session.id,
            @trial_order
          )
          expect(stimulus).to be_nil
        end
      end
    end
  end
end
