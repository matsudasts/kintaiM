class ModifyKintais < ActiveRecord::Migration[5.0]
  def change
    add_column :kintais, :kintai_year, :string
    add_column :kintais, :kintai_month, :string
    add_column :kintais, :kintai_day, :string
  end
end
