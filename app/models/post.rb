class Post < ActiveRecord::Base

  acts_as_nested_set

  attr_accessible :body, :title, :parent_id

  belongs_to :user
  validates :body, :presence => true

  after_create :mail_parent, :if => :child?

  default_scope :order => "created_at DESC"

  def mail_parent
    PostMailer.replied_at(self).deliver
  end

end
