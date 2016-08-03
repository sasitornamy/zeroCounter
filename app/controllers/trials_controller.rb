class TrialsController < ApplicationController

  def new
    @stimulus = Stimulus.excluded_id(session[:completed_stimulus_ids]).random.first
    @trial = Trial.new
    @trial.stim_id = @stimulus.id
  end

  def create
    params = trial_params.merge(
      session_id: Session.find(session[:experiment_session_id]).id
    )
    @trial = Trial.new(params)
    @trial.update_response_result
    @trial.update_stimulus_order
    @stimulus = Stimulus.find(@trial.stim_id)

    if @trial.save
      session[:completed_stimulus_ids].push(@stimulus.id)
      render :new
    else
      flash.now[:error] = @trial.errors.full_messages[0]
      render :new
    end
  end

  private

  def trial_params
    params.require(:trial).permit(:stim_id, :response)
  end

end
