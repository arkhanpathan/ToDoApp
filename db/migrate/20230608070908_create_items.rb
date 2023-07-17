class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :title
      t.text :description
      t.datetime :start_date_time
      t.datetime :end_date_time

      t.timestamps
    end
  end
end 
