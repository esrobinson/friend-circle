# == Schema Information
#
# Table name: post_shares
#
#  id         :integer          not null, primary key
#  circle_id  :integer          not null
#  post_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PostShare < ActiveRecord::Base
  attr_accessible :circle_id, :post_id
  validates :circle, :post, :presence => true

  belongs_to :circle, :inverse_of => :post_shares
  belongs_to :post, :inverse_of => :post_shares
end
