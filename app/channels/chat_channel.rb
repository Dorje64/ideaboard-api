class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def render
    # ActionCable.server.broadcast('chat_channel',message: 'broadcasting message from server')
  end

end
