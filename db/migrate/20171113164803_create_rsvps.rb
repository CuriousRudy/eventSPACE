class CreateRsvps < ActiveRecord::Migration[5.1]
  def change
    create_table :rsvps do |t|
      t.integer :event_id
      t.integer :user_id
      t.string :attending
    end
  end
end
