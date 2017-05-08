class EventPresenter < ApplicationPresenter
  def on_facebook?
    facebook_url.present?
  end

  def description
    model.facebook_description
  end

  def time
    model.starts_at.strftime '%a %b %e @ %l:%M %p'
  end

  def ends_at
    model.ends_at.to_s :long
  end
end
