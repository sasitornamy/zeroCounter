require 'rails_helper'

feature 'complete experiment session' do
  background do
    Stimulus.create(number_of_zeros: 10)
    visit root_path
    page.check('consent')
    click_button 'Proceed'
    click_link 'Proceed'
    fill_in :trial_response, with: 10
    click_on 'Submit'
    click_on 'Next'
  end
  context 'submit mechanical turk ID' do
    context 'valid data' do
      background do
        fill_in :experiment_session_mechanical_turk_id, with: 'a1'
        click_on 'Submit'
      end
      scenario 'indicates that the experiment session is completed' do
        expect(page).to have_content 'Your experiment has been completed.'
        expect(page).not_to have_content 'Mechanical Turk ID:'
      end
    end
    context 'invalid data' do
      background do
        fill_in :experiment_session_mechanical_turk_id, with: '%1'
        click_on 'Submit'
      end
      scenario 'returns invalid data error' do
        expect(page).to have_content 'is invalid'
      end
    end
  end
end
