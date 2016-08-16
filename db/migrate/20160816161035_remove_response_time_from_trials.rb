class RemoveResponseTimeFromTrials < ActiveRecord::Migration
  def change
    remove_column :trials, :response_time, :integer
  end
end
