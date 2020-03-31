# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class ChatroomsChannel < ApplicationCable::Channel
  def subscribed
    current_user.chatrooms.each do |chatroom|
      stream_from "chatrooms:#{chatroom.id}"
    end
  end

  def unsubscribed
    stop_all_streams
  end

  def speak(message)
    puts "#{message}"
    @chatroom = Chatroom.find(message["channelId"])
    message = @chatroom.messages.new(body: message["body"] )
    message.user = current_user
    message.save
    ActionCable.server.broadcast "chatrooms:#{message.chatroom.id}", {
      username: message.user.username,
      body: message.body,
      chatroom_id: message.chatroom.id
    }
    head :ok
  end
end
