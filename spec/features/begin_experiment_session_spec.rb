require 'rails_helper'

feature 'begin experiment session' do
  background do
    visit '/experiment_sessions/introduction'
  end
  context 'user clicks Proceed button' do
    context 'user does not agree to the consent form' do
      scenario 'shows the error message' do
        click_button 'Proceed'
        expect(page).to have_content 'please indicate that you agree to the consent form'
      end
    end
    context 'user agrees to the consent form' do
      before do
        page.check('consent')
      end
      scenario 'goes to the instruction page' do
        click_button 'Proceed'
        expect(page).to have_content 'Instructions'
      end
    end
  end
end
