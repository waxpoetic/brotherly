class RecommendationsPresenter < Makeover::Presenter
  include Makeover::Presentable

  delegate :each, to: :records

  def each
    records.each do |record|
      present(record, with: RecommendationPresenter)
    end
  end

  private

  def records
    @records ||= model.performances + latest_episodes
  end

  def latest_episodes
    Episode.latest.where.not id: id
  end
end
