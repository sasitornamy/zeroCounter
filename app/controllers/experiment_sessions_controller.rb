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

  private

  def experiment_session_params
    params.require(:experiment_session).permit(:consent_given)
  end

end
