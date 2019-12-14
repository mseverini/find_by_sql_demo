class CreateActiveUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :active_users do |t|
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
