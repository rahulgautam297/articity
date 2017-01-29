class CreateUserSkills < ActiveRecord::Migration[5.0]
  def change
    create_table :user_skills do |t|
      t.references :user, foreign_key: true, null: false
      t.references :skill, foreign_key: true, null: false

      t.timestamps
    end
  end
end
