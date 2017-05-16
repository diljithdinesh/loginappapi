class CreateUserInfos < ActiveRecord::Migration[5.0]
  def change
    create_table :user_infos do |t|
      t.string :firstname
      t.string :lastname
      t.string :email
      t.string :gender
      t.string :address
      t.string :pincode
      t.string :phone
      t.integer :user_id

      t.timestamps
    end
  end
end
