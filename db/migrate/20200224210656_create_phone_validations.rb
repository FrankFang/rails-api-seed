class CreatePhoneValidations < ActiveRecord::Migration[6.0]
  def change
    create_table :phone_validations do |t|
      t.string :phone
      t.string :code
      t.datetime :used_at

      t.timestamps
    end
  end
end
