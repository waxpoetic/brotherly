class Admin::UserDecorator < ApplicationDecorator
  delegate_all

  def login
    "~" + name
  end
end
