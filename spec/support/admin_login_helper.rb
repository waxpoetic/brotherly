# frozen_string_literal: true
module AdminLoginHelper
  def sign_in!
    sign_in users(:admin)
  end
end
