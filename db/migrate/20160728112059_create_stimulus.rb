class CreateStimulus < ActiveRecord::Migration
  def change
    create_table :stimulus do |t|
      t.integer :stim_id
      t.integer :num_digits
      t.integer :num_zeros
      t.text :image_path

      t.timestamps null: false
    end
  end
end
