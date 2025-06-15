class CreateJobViews < ActiveRecord::Migration[7.1]
  def change
    create_table :job_views do |t|
      t.references :job, null: false, foreign_key: true

      t.timestamps
    end
    add_index :job_views, :created_at
  end
end
