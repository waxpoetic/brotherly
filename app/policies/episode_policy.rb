class EpisodePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def update?
    super && record.future?
  end

  def current?
    true
  end
end
