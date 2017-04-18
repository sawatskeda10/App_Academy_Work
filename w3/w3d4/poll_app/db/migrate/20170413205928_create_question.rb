class CreateQuestion < ActiveRecord::Migration[5.0]
  def change
    create_table :questions do |t|
      t.integer :poll_id, null: false
      t.text :question, null: false

      t.timestamps
    end
  end
end
