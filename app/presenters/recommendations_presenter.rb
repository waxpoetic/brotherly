class RecommendationsPresenter < Makeover::Presenter
  include Makeover::Presentable

  def each
    records.each do |record|
      present(record, with: RecommendationPresenter)
    end
  end

  private

  def records
    @records ||= model.performances.to_a + latest_episodes.to_a
  end

  def latest_episodes
    Episode.latest.where.not id: id
  end
end
