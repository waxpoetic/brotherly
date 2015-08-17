class EpisodeDecorator < Draper::Decorator
  delegate_all

  def title
    if model.future?
      'next episode...'
    else
      'latest episode'
    end
  end
end
