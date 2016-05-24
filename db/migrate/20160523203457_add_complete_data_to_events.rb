class AddCompleteDataToEvents < ActiveRecord::Migration
  def change
    add_column :events, :done_summary, :text
    add_column :events, :done_additional, :text
    add_column :events, :done_created_at, :datetime
  end
end
