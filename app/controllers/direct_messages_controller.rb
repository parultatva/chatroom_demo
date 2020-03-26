class DirectMessagesController < ApplicationController
  # before_action :authenticate_user!

  #GET /direct_messages/:id (show message)
  def show
    users = [current_user, User.find(params[:id])]
    @chatroom = Chatroom.direct_message_for_users(users)
    @messages = @chatroom.messages.order(created_at: :desc).limit(100).reverse
    @chatroom_user = current_user.chatroom_users.find_by(chatroom_id: @chatroom.id)
    # render :json => @messages
    # serialized_data = ActiveModelSerializers::Adapter::Json.new(
    #     MessageSerializer.new(@messages)
    #   ).serializable_hash


    # serialized_data = 
    # json_response({
    #   success: true,
    #   data: {
    #     messages: ActiveModel::Serializer::CollectionSerializer.new(@chatroom,serializer: ChatroomSerializer),
    #   }
    # }, 200)

    json_response({
      success: true,
      data: {
        chatroom: ActiveModelSerializers::SerializableResource.new(@chatroom,serializer: ChatroomSerializer),
      }
    }, 200)

    
    # render "chatrooms/show"
  end
end
