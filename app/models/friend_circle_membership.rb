# == Schema Information
#
# Table name: friend_circle_memberships
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  circle_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class FriendCircleMembership < ActiveRecord::Base
  attr_accessible :circle_id, :user_id

  validates :circle, :user, :presence => :true
  # validates_uniqueness_of :circle, :scope => :user

  belongs_to :circle, :inverse_of => :friend_circle_memberships
  belongs_to :user, :inverse_of => :friend_circle_memberships

end
