class CreateIndustries < ActiveRecord::Migration[7.1]
  def change
    create_table :industries do |t|
      t.string :name, null: false
      t.text :description

      t.timestamps
    end
  end
end
