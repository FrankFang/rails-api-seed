class RemovePhoneValidations < ActiveRecord::Migration[6.0]
  def change
    drop_table :phone_validations
  end
end
