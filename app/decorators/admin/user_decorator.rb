class Admin::UserDecorator < ApplicationDecorator
  decorates User
  delegate_all

  def login
    "~" + name
  end
end
