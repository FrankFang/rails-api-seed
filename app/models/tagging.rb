# == Schema Information
#
# Table name: taggings
#
#  id           :bigint           not null, primary key
#  discarded_at :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  record_id    :bigint           not null
#  tag_id       :bigint           not null
#  user_id      :bigint           not null
#
# Indexes
#
#  index_taggings_on_discarded_at  (discarded_at)
#  index_taggings_on_record_id     (record_id)
#  index_taggings_on_tag_id        (tag_id)
#  index_taggings_on_user_id       (user_id)
#
class Tagging < ApplicationRecord
  include Discard::Model
  belongs_to :tag
  belongs_to :user
  belongs_to :record
end
