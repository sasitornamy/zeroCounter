class CreateTrials < ActiveRecord::Migration
  def change
    create_table :trials do |t|
      t.integer :session_id
      t.integer :stim_id
      t.integer :order_appeared
      t.integer :response
      t.boolean :response_result
      t.integer :resp_time

      t.timestamps null: false
    end
  end
end
