class Admin::UserDecorator < AdminDecorator
  decorates User
  delegate_all

  def login
    "~" + name
  end

  def title
    model.name.downcase
  end

  def role
    if model.is_admin?
      'Administrator'
    else
      'User'
    end
  end

  def fields
    %w(email current_sign_in_at last_sign_in_at current_sign_in_ip last_sign_in_ip is_admin)
  end
end
