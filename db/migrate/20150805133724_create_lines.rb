class CreateLines < ActiveRecord::Migration
  def change
    create_table :lines do |t|
      t.references :place, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
