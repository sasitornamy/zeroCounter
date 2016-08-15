class ExperimentSessionsController < ApplicationController

  def new
    @experiment_session = ExperimentSession.new
  end

  def create
    @experiment_session = ExperimentSession.new(
      experiment_session_params.merge( started_at: Time.now )
    )
    if @experiment_session.save
      render :instructions
    else
      flash.now[:error] = @experiment_session.errors.full_messages[0]
      render :new
    end
  end

  def update
    @experiment_session = ExperimentSession.find(params[:id])
    if @experiment_session.update(experiment_session_params)
      flash.now[:success] = 'Your experiment has been completed.'
      render :complete
    else
      flash.now[:error] = @experiment_session.errors.full_messages[0]
      render :complete
    end
  end

  private

  def experiment_session_params
    params.require(:experiment_session).permit(
      :consent_given,
      :mechanical_turk_id,
      :number_of_trials
    )
  end

end
