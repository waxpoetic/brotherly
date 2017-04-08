# Copy data from production onto staging periodically. Report errors to
# the Rails log.
class CopyProductionDataJob < ApplicationJob
  queue_as :default

  delegate :warn, to: Rails.logger

  def perform
    raise 'Cannot execute on non-staging deployments' unless staging?

    Brotherly::Seed.all.each do |seed|
      if seed.response.success?
        seed.clear!
        seed.data.each do |params|
          record = model.create(params)
          warn record.errors.full_messages.to_sentence unless record.valid?
        end
      end
    end
  end

  private

  def staging?
    Brotherly.stage == 'staging'
  end
end
