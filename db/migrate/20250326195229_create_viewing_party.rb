class CreateViewingParty < ActiveRecord::Migration[7.1]
  def change
    create_table :viewing_parties do |t|
      t.string :name
      t.time :start_time
      t.time :end_time
      t.integer :movie_id

      t.timestamps
    end
  end
end
