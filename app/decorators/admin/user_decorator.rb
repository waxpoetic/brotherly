class Admin::UserDecorator < Draper::Decorator
  delegate_all

  def login
    "~" + name
  end
end
