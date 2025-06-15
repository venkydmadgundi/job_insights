class CreateJobs < ActiveRecord::Migration[7.1]
  def change
    create_table :jobs do |t|
      t.string :title, null: false
      t.text :description
      t.references :industry, null: false, foreign_key: true
      t.integer :clicks, default: 0
      t.integer :applied, default: 0

      t.timestamps
    end
    add_index :jobs, :title
  end
end
