class User < ActiveRecord::Base
  include Searchable

  searchable email: 'A', name: 'B'

  # friendly_id :name

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
