class Admin::UserDecorator < ApplicationDecorator
  decorates User
  delegate_all

  def login
    "~" + name
  end

  def fields
    %w(name email current_sign_in_at last_sign_in_at current_sign_in_ip last_sign_in_ip confirmed_at is_admin)
  end
end
