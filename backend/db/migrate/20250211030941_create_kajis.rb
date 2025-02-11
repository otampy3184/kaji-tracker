class CreateKajis < ActiveRecord::Migration[8.0]
  def change
    create_table :kajis do |t|
      t.string :title
      t.text :content
      t.integer :points

      t.timestamps
    end
  end
end
