class AddAveragePriceToLabels < ActiveRecord::Migration[5.2]
  def change
    add_column :labels, :average_price, :float, default: 0.0
  end
end
