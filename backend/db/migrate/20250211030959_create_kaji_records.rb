class CreateKajiRecords < ActiveRecord::Migration[8.0]
  def change
    create_table :kaji_records do |t|
      t.references :user, null: false, foreign_key: true
      t.references :kaji, null: false, foreign_key: true
      t.datetime :performed_date

      t.timestamps
    end
  end
end
