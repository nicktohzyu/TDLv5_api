class CreateEntries < ActiveRecord::Migration[6.0]
  def change
    create_table :entries do |t|
      t.text :content
      t.date :due_date
      t.references :user, null: false, foreign_key: true
      t.boolean :done

      t.timestamps
    end
  end
end
