class CreateExperimentSessions < ActiveRecord::Migration
  def change
    create_table :experiment_sessions do |t|
      t.datetime :started_at
      t.integer :user_id
      t.text :mechanical_turk_id
      t.integer :number_of_trials
      t.boolean :consent_given

      t.timestamps null: false
    end
  end
end
