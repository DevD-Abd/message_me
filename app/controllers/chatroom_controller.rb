class ChatroomController < ApplicationController
    def index
        @messages = Message.includes(:user).order(created_at: :desc)
    end
end