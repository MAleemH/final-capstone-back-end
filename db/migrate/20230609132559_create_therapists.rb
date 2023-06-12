class CreateTherapists < ActiveRecord::Migration[7.0]
  def change
    create_table :therapists do |t|
      t.string :name
      t.string :email
      t.string :specialization
      t.string :phone
      t.text :photo
      t.boolean :availability, default: true
      t.text :address
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
