class PostMailer < ActionMailer::Base
  default from: "notifications@postrface.com"

  def replied_at(post)
    @post = post.parent
    @writer = post.user
    @reciever = post.parent.user

    mail to: @reciever.email, subject: "#{@writer.username} replied"
  end
end
