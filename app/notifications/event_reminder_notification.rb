# To deliver this notification:
#
# EventReminderNotification.with(post: @post).deliver_later(current_user)
# EventReminderNotification.with(post: @post).deliver(current_user)

class EventReminderNotification < Noticed::Base
  # Add your delivery methods
  #
  deliver_by :database
  # deliver_by :email, mailer: "UserMailer"
  # deliver_by :slack
  deliver_by :custom, class: 'DeliveryMethods::AfricasTalking'

  # Add required params
  #
  # param :post

  # Define helper methods to make rendering easier.
  #
  def message
    # t(".message")
    "Event #{event} due in 1 day. Please prepare yourself accordingly. Thanks!"
  end
  #
  # def url
  #   post_path(params[:post])
  # end
end
