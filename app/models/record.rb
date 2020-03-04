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
class Record < ApplicationRecord
  include Discard::Model
  belongs_to :user
  has_many :taggings
  has_many :tags, through: :taggings
  accepts_nested_attributes_for :tags, allow_destroy: true
  enum category: {outgoings: 0, income: 1}
  validates_presence_of :amount, :category

  def tag_ids=(ids)
    # self.tags = ids.map { |id| Tag.find id } # invalid
    ids.each { |id| Tagging.find_or_create_by(tag_id: id, user: user, record: self) }
  end
end
