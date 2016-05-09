# Chat message.
class Message
  include ActiveModel::Model

  TYPES = %w(message notice)

  attribute :author
  attribute :body
  attribute :type, default: TYPES.first

  validates :author, presence: true, unless: :system?
  validates :body, presence: true
  validates :type, presence: true, inclusion: { in: TYPES }

  def self.create(params = {})
    new(params).tap(:save)
  end

  def id
    @id ||= SecureRandom.uuid
  end

  def attributes
    {
      id: id,
      type: type,
      author: author,
      body: content
    }
  end

  def save
    valid? && create
  end

  def persisted?
    @persisted ||= false
  end

  def system?
    type == 'notice'
  end

  private

  def create
    @persisted = ActionCable.server.broadcast :messages, attributes
  end
end
