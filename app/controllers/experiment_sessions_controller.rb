class ExperimentSessionsController < ApplicationController

  def create
    if params[:consent] == '1'
      experiment_session = Session.create(
        started_at: Time.now,
        user: User.create( status: 'subject' )
      )
      session[:experiment_session_id] = experiment_session.id
      session[:completed_stimulus_ids] = []
      render :instructions
    else
      flash.now[:error] = 'To proceed, please indicate that you agree to the consent form.'
      render :introduction
    end
  end

end
