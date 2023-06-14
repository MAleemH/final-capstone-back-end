class CreateRevokedTokens < ActiveRecord::Migration[7.0]
  def change
    create_table :revoked_tokens do |t|
      t.string :token
      t.timestamps
    end
    add_index :revoked_tokens, :token
  end
end
