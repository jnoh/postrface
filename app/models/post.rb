class Post < ActiveRecord::Base
  attr_accessible :body, :title

  belongs_to :user
  validates :body, :presence => true

  default_scope :order => "created_at DESC"


end
