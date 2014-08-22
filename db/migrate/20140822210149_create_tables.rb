class CreateTables < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.column :name, :string
    end

    create_table :questions do |t|
      t.column :name, :string
      t.column :survey_id, :integer
    end

    create_table :responses do |t|
      t.column :name, :string
      t.column :question_id, :integer
    end
  end
end
