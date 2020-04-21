# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  email           :string
#  name            :string
#  password_digest :string
#  phone           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
  has_secure_password
  has_many :tags
  has_many :records
  has_many :taggings

  validates_presence_of :password, on: [:create]
  validates :password, length: {in: 6..20}, allow_blank: true

  after_create do
    UserMailer.with(user: self).welcome_email.deliver_later
  end

  def as_json(options)
    options ||= {}
    options[:except] ||= []
    options[:except] += [:password, :password_digest, :password_confirmation]
    super(options)
  end
end
