class MessageSerializer < ActiveModel::Serializer
  attributes :id, :chatroom_id, :user_id, :username, :body, :created_at, :updated_at
  has_many :attachments, key: "attachments", serializer: AttachmentSerializer

  def username
  	User.find(object.user_id).try(:username)
  end
end
