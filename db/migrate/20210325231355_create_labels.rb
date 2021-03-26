class CreateLabels < ActiveRecord::Migration[5.2]
  def change
    create_table :labels do |t|
      t.string :description
      t.integer :image_id

      t.timestamps
    end
  end
end
