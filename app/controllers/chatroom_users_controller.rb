class ChatroomUsersController < ApplicationController
  # before_action :authenticate_user!
  before_action :set_chatroom

  # POST /chatrooms/:chatroom_id/chatroom_users (join)
  def create
    @chatroom_user = @chatroom.chatroom_users.where(user_id: current_user.id).first_or_create
    # redirect_to @chatroom
    render :json => @chatroom_user
  end

  # DELETE /chatrooms/:chatroom_id/chatroom_users (leave)
  def destroy
    @chatroom_user = @chatroom.chatroom_users.where(user_id: current_user.id).destroy_all
    # redirect_to chatrooms_path
    render :json => {:success => "Leave the Chatroom"}
  end

  private

    def set_chatroom
      @chatroom = Chatroom.find(params[:chatroom_id])
    end
end
