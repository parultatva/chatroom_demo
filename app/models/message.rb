class Message < ApplicationRecord
  belongs_to :chatroom
  belongs_to :user
  has_many :attachments, dependent: :destroy
end
