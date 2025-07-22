class ChatroomController < ApplicationController
    before_action :require_user
    def index
        @messages = Message.includes(:user).order(created_at: :desc)
    end
end