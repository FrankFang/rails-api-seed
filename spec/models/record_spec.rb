# == Schema Information
#
# Table name: records
#
#  id           :bigint           not null, primary key
#  amount       :integer
#  category     :integer          not null
#  discarded_at :datetime
#  notes        :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :bigint
#
# Indexes
#
#  index_records_on_discarded_at  (discarded_at)
#  index_records_on_user_id       (user_id)
#
require 'rails_helper'

RSpec.describe Record, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
