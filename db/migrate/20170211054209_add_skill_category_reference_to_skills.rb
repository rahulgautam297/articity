class AddSkillCategoryReferenceToSkills < ActiveRecord::Migration[5.0]
  def change
    add_reference :skills, :skill_category, foreign_key: true
    add_column :skills, :description, :string, default: "Please add description."
  end
end
