require 'rails_helper'

feature 'begin experiment session' do
  background do
    visit root_path
  end
  context 'user clicks Proceed button' do
    context 'user does not agree to the consent form' do
      scenario 'shows the error message' do
        click_button 'Proceed'
        expect(page).to have_content 'must be accepted'
      end
    end
    context 'user agrees to the consent form' do
      before do
        page.check('experiment_session[consent_given]')
      end
      scenario 'begins the trial' do
        click_button 'Proceed'
        expect(page).to have_content 'Instructions'
      end
    end
  end
end
