class ChangeDateToStringInViewingParty < ActiveRecord::Migration[7.1]
  def change
    change_column :viewing_parties, :start_time, :string
    change_column :viewing_parties, :end_time, :string
  end
end
