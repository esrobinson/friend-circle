class Upvote < ActiveRecord::Base
  attr_accessible :post_id, :user_id
  validates :post, :user, :presence => true

  belongs_to :user
  belongs_to :post
end
