class CreateMembers < ActiveRecord::Migration[5.1]
  def change
    create_table :members do |t|
      t.string :first_name
      t.string :last_name
      t.string :url
      t.string :short_url

      t.timestamps
    end
  end
end
