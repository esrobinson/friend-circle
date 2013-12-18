# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  body       :string(255)      not null
#  author_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ActiveRecord::Base
  attr_accessible :body, :circles, :circle_ids
  validates :author, :body, :presence => true

  belongs_to :author, :class_name => "User"
  has_many :post_shares, :inverse_of => :post
  has_many :circles, :through => :post_shares
  has_many :links, :inverse_of => :post
  has_many :upvotes
  has_many :upvoters, :through => :upvotes, :source => :user

  accepts_nested_attributes_for :post_shares
end
