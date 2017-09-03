class CreateKintais < ActiveRecord::Migration[5.0]
  def change
    create_table :kintais do |t|
      t.datetime :kintai_from
      t.datetime :kintai_to
      t.string :kintai_year
      t.string :kintai_month
      t.string :kintai_day
      t.date :kintai_date
      t.timestamps null: false
    end
  end
end
