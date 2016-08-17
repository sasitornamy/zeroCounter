class CreateTrialInteractions < ActiveRecord::Migration
  def change
    create_table :trial_interactions do |t|
      t.integer :trial_id
      t.integer :response_time
      t.integer :time_since_answer_revealed_to_next_question
      t.text :keystrokes

      t.timestamps null: false
    end
  end
end
