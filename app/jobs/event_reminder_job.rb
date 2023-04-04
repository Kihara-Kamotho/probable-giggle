class EventReminderJob < ApplicationJob
  queue_as :default

  def perform(event)
    # if event is due in a days time
    return unless event.date < Time.now + 1.day

    # send notification
    EventReminderNotification.with(event:).deliver(current_user)
  end
end
