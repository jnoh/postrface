class User < ActiveRecord::Base

  attr_accessible :email, :password, :password_confirmation, :username

  authenticates_with_sorcery!

  has_many :posts

  before_validation :trim_and_downcase_username, :on => :create

  username_regex = /\A[A-Za-z0-9_]+\z/
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates_presence_of :username
  validates_length_of :username, :maximum => 32
  validates_format_of :username, :with => username_regex 
  validates_uniqueness_of :username, :case_sensitive => false

  validates_uniqueness_of :email, :case_senstive => false
  validates_presence_of :email
  validates_format_of :email, :with => email_regex

  validates_length_of :password, :minimum => 6, :message => "must be at least 6 characters long", :if => :password

  private

    def trim_and_downcase_username
      if username.present?
        username.strip!
        username.downcase!
      end
    end
end
