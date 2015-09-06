module Brotherly
  # Base class for one-time worker script objects.
  class Worker
    include ActiveModel::Model

    attr_accessor :model

    validates :model, presence: { message: 'not defined' }

    define_model_callbacks :save, :perform

    # Create a new worker, run validations and perform its task.
    #
    # @param [ActiveModel::Model] model
    # @returns [Worker]
    def self.perform(model)
      worker = new model: model
      worker.save
      worker
    end

    # Run validations and perform the worker task.
    #
    # @return [Boolean]
    def save
      run_callbacks :save do
        valid? && perform!
      end
    end

    # Whether the perform was successful.
    #
    # @return [Boolean]
    def persisted?
      @persisted ||= false
    end
    alias_method :performed?, :persisted?

    # Define this method to make your worker class do something. It must
    # return a boolean in order to populate +persisted?+.
    #
    # @returns [Boolean]
    # @throw [NotImplementedError] when not defined.
    def perform
      raise NotImplementedError, "You must define #perform"
    end

    private

    # Call the +perform+ method on this object and handle any errors
    # that arise. Set whether the perform succeeded on the +@persisted+
    # instance variable to be recalled later by +performed?+.
    #
    # @private
    # @return [Boolean]
    def perform!
      run_callbacks :perform do
        @persisted = perform
      end
    rescue StandardError => exception
      errors.add :base, "could not perform task: #{exception.message}"
      @persisted = false
    rescue NotImplementedError => exception
      errors.add :base, exception.message
      @persisted = false
    end
  end
end
