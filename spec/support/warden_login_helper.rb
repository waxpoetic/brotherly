# frozen_string_literal: true

module WardenLoginHelper
  def sign_in(user)
    login_as user, scope: :user
  end

  def sign_out
    logout :user
  end
end
