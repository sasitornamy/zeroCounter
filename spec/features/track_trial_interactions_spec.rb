require 'rails_helper'

feature 'track trial interactions' do
  background do
    Stimulus.create(number_of_zeros: 10)
    visit root_path
    page.check('consent')
    click_button 'Proceed'
    click_link 'Proceed'
  end
  context 'a trial page displays' do
    context '#response_time' do
      background do
        fill_in :trial_response, with: 10
        click_on 'Submit'
      end
      scenario 'tracks response time' do
        trial_interaction = TrialInteraction.last
        expect(trial_interaction.response_time).not_to be_nil
      end
    end

    context '#time_since_answer_revealed_to_next_question' do
      background do
        fill_in :trial_response, with: 10
        click_on 'Submit'
        click_on 'Next'
      end
      scenario 'tracks time between reveal answer and next button clicked' do
        trial_interaction = TrialInteraction.last
        expect(trial_interaction.time_since_answer_revealed_to_next_question)
          .not_to be_nil
      end
    end

    context '#keystrokes', js: true do
      context 'the validation passed on the save' do
        background do
          fill_in :trial_response, with: 9
          fill_in :trial_response, with: 10
          click_on 'Submit'
        end
        scenario 'tracks the keystrokes correctly' do
          expect(page).to have_selector('.answer', visible: true)
          trial_interaction = TrialInteraction.last
          expect(trial_interaction.keystrokes).to eq('9,1,0')
        end
        context 'next trial' do
          background do
            Stimulus.create(number_of_zeros: 8)
            click_on 'Next'
            fill_in :trial_response, with: 8
            click_on 'Submit'
          end
          scenario 'tracks the new keystrokes' do
            expect(page).to have_selector('.answer', visible: true)
            trial_interaction = TrialInteraction.last
            expect(trial_interaction.keystrokes).to eq('8')
          end
        end
      end
      context 'the validation failed on the save' do
        background do
          fill_in :trial_response, with: 'ab'
          click_on 'Submit'
        end
        scenario 'tracks the keystrokes correctly' do
          fill_in :trial_response, with: 12
          click_on 'Submit'
          expect(page).to have_selector('.answer', visible: true)
          trial_interaction = TrialInteraction.last
          expect(trial_interaction.keystrokes).to eq('a,b,1,2')
        end
      end
    end

  end
end
