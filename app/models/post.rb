class Post < ActiveRecord::Base

  acts_as_nested_set

  attr_accessible :body, :title, :parent_id

  belongs_to :user
  validates :body, :presence => true

  default_scope :order => "created_at DESC"


end
