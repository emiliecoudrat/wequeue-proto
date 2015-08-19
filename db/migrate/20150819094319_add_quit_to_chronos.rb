class AddQuitToChronos < ActiveRecord::Migration
  def change
    add_column :chronos, :quit, :boolean
  end
end
