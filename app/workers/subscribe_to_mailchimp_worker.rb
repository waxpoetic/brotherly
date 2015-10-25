class SubscribeToMailchimpWorker < Brotherly::Worker
  delegate :name, :email, to: :model
end
