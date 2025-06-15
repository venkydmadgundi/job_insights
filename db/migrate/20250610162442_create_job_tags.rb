class CreateJobTags < ActiveRecord::Migration[7.1]
  def change
    create_table :job_tags do |t|
      t.references :job, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end
    add_index :job_tags, [:job_id, :tag_id], unique: true
  end
end
