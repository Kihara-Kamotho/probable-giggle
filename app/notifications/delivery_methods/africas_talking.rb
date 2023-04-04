# frozen_string_literal: true

module DeliveryMethods
  class AfricasTalking < Noticed::DeliveryMethods::Base # rubocop:disable Style/Documentation
    # override the default deliver method of noticed
    def deliver
      AfricasTalking::SmsClient.new(phone: [recipient.phone], message: notification.message).send
    end
  end
end
