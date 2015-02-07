class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.string :name ,empty: false
      t.string :definition, empty:false

      t.timestamps null: false
    end
  end
end
