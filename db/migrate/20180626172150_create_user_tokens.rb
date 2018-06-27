class CreateUserTokens < ActiveRecord::Migration
  def change
    create_table :user_tokens do |t|
      t.string :token, unqiue: true
      t.belongs_to :user, index: true
      t.timestamps null: false
    end
  end
end
