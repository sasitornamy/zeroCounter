require 'rails_helper'

feature 'export data to xlsx' do
  background do
    visit admin_path
  end
  context 'experiment sessions exist' do
    scenario 'shows the current date as a default of the end date' do
      expect(find_field('end_date').value).to eq Date.today.to_s
    end
    context 'valid date range' do
      background do
        experiment = ExperimentSession.create(consent_given: true)
        fill_in :start_date, with: Date.today.to_s
        fill_in :end_date, with: Date.today.to_s
        click_button 'Submit'
      end
      scenario 'exports an xlsx file' do
        expect(page.response_headers['Content-Disposition'])
          .to match 'experiments_data.xlsx'
      end
    end

    context 'invalid date range' do
      background do
        fill_in :start_date, with: '02/20/2016'
        fill_in :end_date, with: '01/20/2016'
        click_button 'Submit'
      end
      scenario 'shows the appropiate error' do
        expect(page).to have_content 'end date cannot be earlier than the start date'
        expect(page.response_headers['Content-Disposition']).to be_nil
      end
    end

    context 'start date is not present' do
      background do
        fill_in :start_date, with: ''
        fill_in :end_date, with: '01/20/2016'
        click_button 'Submit'
      end
      scenario 'shows the appropiate error' do
        expect(page).to have_content 'dates are required'
        expect(page.response_headers['Content-Disposition']).to be_nil
      end
    end
  end
end
