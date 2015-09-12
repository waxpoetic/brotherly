class SubscriberDecorator < Draper::Decorator
  delegate_all

  def thank_you_message
    if model.name.present?
      "Thanks #{name}!"
    else
      "Thanks!"
    end
  end
end
