class CreateTags < ActiveRecord::Migration[6.0]
  def change
    create_table :tags do |t|
      t.string :content
      t.references :entry, null: false, foreign_key: true

      t.timestamps
    end
  end
end
