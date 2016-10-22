# frozen_string_literal: true
class SubscriberPresenter < ApplicationPresenter
  def thank_you_message
    if model.name.present?
      "Thanks #{name}!"
    else
      'Thanks!'
    end
  end
end
