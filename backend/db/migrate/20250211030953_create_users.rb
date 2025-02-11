class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :uid
      t.string :name
      t.string :email
      t.string :photo_url
      t.integer :total_points

      t.timestamps
    end
  end
end
