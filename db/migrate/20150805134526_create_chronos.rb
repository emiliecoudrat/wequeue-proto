class CreateChronos < ActiveRecord::Migration
  def change
    create_table :chronos do |t|
      t.references :user, index: true, foreign_key: true
      t.references :line, index: true, foreign_key: true
      t.datetime :checked_in_at
      t.datetime :checked_out_at
      t.integer :manually_added_duration_in_minutes

      t.timestamps null: false
    end
  end
end
