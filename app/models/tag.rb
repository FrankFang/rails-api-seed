# == Schema Information
#
# Table name: tags
#
#  id           :bigint           not null, primary key
#  discarded_at :datetime
#  name         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :bigint
#
# Indexes
#
#  index_tags_on_discarded_at  (discarded_at)
#  index_tags_on_user_id       (user_id)
#
class Tag < ApplicationRecord
  include Discard::Model

  belongs_to :user
  has_many :taggings
  has_many :records, through: :taggings
  paginates_per 50
  validates_presence_of :name
  validates :name, length: {in: 1..10}
end
