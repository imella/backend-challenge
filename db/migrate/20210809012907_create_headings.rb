class CreateHeadings < ActiveRecord::Migration[5.1]
  def change
    create_table :headings do |t|
      t.string :name
      t.belongs_to :member, foreign_key: true

      t.timestamps
    end
  end
end
