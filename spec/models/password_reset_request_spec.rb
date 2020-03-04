# == Schema Information
#
# Table name: password_reset_requests
#
#  id         :bigint           not null, primary key
#  code       :string(256)
#  email      :string(100)
#  used_at    :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_password_reset_requests_on_code   (code)
#  index_password_reset_requests_on_email  (email)
#
require 'rails_helper'

RSpec.describe PasswordResetRequest, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
