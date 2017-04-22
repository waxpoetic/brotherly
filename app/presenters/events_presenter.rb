class EventsPresenter < CollectionPresenter
  def to_ary
    model.map { |event| EventPresenter.new event }
  end
end
