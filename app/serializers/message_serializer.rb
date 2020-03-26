class MessageSerializer < ActiveModel::Serializer
  attributes :id, :chatroom_id, :user_id, :username, :body, :created_at, :updated_at

  def username
  	User.find(object.user_id).try(:username)
  end
end
