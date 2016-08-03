class CreateStimuli < ActiveRecord::Migration
  def change
    create_table :stimuli do |t|
      t.integer :number_of_digits
      t.integer :number_of_zeros
      t.text :image_path

      t.timestamps null: false
    end
  end
end
