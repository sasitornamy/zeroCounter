require 'rails_helper'

feature 'submit answer' do
  background do
    Stimulus.create(num_zeros: 10)
    visit root_path
    page.check('consent')
    click_button 'Proceed'
    click_link 'Proceed'
  end
  context 'correct answer' do
    background do
      fill_in :trial_response, with: 10
      click_on 'Submit'
    end
    scenario 'displays correct message' do
      expect(page).to have_content 'CORRECT'
    end
  end
  context 'incorrect answer' do
    background do
      fill_in :trial_response, with: 5
      click_on 'Submit'
    end
    scenario 'displays incorrect message' do
      expect(page).to have_content 'INCORRECT'
    end
  end
  context 'invalid answer' do
    background do
      fill_in :trial_response, with: 'one'
      click_on 'Submit'
    end
    scenario 'displays error message' do
      expect(page).to have_content 'Response is not a number'
    end
  end
  context 'complete the question' do
    background do
      Stimulus.create(num_zeros: 9)
      fill_in :trial_response, with: 10
      click_on 'Submit'
      click_on 'Next'
    end
    scenario 'shows the next question' do
      expect(page).to have_content 'Complete the Task'
      expect(find_field('trial_response').value).to be_nil
      expect(page).not_to have_content 'CORRECT'
    end
  end

end
