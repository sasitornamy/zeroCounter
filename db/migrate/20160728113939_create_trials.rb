class CreateTrials < ActiveRecord::Migration
  def change
    create_table :trials do |t|
      t.integer :experiment_session_id
      t.integer :stimulus_id
      t.integer :order_appeared
      t.integer :response
      t.boolean :response_result
      t.integer :response_time

      t.timestamps null: false
    end
  end
end
