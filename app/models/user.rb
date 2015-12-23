class User < ActiveRecord::Base
  include Searchable

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  searchable name: 'A'

  # Use ActiveJob to send mails in the background
  #
  # @return [ActiveJob::Base]
  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end
end
