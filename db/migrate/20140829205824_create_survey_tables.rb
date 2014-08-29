class CreateSurveyTables < ActiveRecord::Migration
  def change
    create_table :survey_takers do |t|
      t.column :name, :string
    end

    create_table :survey_responses do |t|
      t.column :survey_taker_id, :integer
      t.column :survey_id, :integer
      t.column :question_id, :integer
      t.column :response_id, :integer
    end
  end
end
