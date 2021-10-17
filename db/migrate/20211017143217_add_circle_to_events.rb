class AddCircleToEvents < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :circle_id, :integer
    add_index :events, :circle_id, name: 'index_on_circle'
  end
end
