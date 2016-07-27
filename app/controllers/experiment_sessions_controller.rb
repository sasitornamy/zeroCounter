class ExperimentSessionsController < ApplicationController
  def introduction
  end

  def create
    if params[:consent] == '1'
      render :instructions
    else
      flash.now[:error] = "To proceed, please indicate that you agree to the consent form."
      render :introduction
    end
  end

  def instructions
  end
end
