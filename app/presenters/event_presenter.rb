class EventPresenter < ApplicationPresenter
  # Timestamp string for the front-end.
  #
  # @return [String]
  def time
    return "#{starts_at} all day" if all_day?
    "from #{starts_at.to_s(:short)} to #{ends_at.to_s(:short)}"
  end

  # Test if this event is occurring all day.
  #
  # @return [Boolean] whether +starts_at+ is not a +DateTime+ object.
  def all_day?
    !starts_at.is_a? DateTime
  end
end
