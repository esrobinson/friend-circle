# == Schema Information
#
# Table name: circles
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Circle < ActiveRecord::Base
  attr_accessible :name, :user_id, :friend_circle_memberships, :member_ids

  validates :name, :user, :presence => true
  # validates_uniqueness_of :name, :scope => :user_id

  has_many :friend_circle_memberships, :inverse_of => :circle
  has_many :members, :through => :friend_circle_memberships, :source => :user
  belongs_to :user
  has_many :post_shares
  has_many :posts, :through => :post_shares

  accepts_nested_attributes_for :friend_circle_memberships
end
