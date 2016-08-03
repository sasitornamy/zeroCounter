class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.integer :session_id
      t.datetime :started_at
      t.integer :user_id
      t.text :mturk_id
      t.integer :num_trials

      t.timestamps null: false
    end
  end
end
