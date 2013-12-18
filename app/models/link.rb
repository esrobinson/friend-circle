# == Schema Information
#
# Table name: links
#
#  id         :integer          not null, primary key
#  post_id    :integer          not null
#  url        :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Link < ActiveRecord::Base
  attr_accessible :post_id, :url
  validates :post, :url, :presence => true

  belongs_to :post, :inverse_of => :links
end
