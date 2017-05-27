class CreateKintais < ActiveRecord::Migration[5.0]
  def change
    create_table :kintais do |t|
      t.date :kintai_date
      t.string :kintai_from
      t.string :kintai_to
      t.timestamps null: false
    end
  end
end
