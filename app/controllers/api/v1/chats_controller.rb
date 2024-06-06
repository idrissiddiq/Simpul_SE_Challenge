module Api
    module V1
        class ChatsController < ApplicationController
            def show_by_sender
                @chat = Chat.where(sender_id: params[:sender_id]).order(:id)
                
                if @chat
                  render json: @chat
                end
            end
            def create
                @chat = Chat.new(chat_params)
                if @chat.save
                    render json: @chat
                else
                    render json: @chat.errors, status: unprocessable_entity
                end
            end

            private

            def chat_params
                params.require(:chat).permit(:sender, :message, :sender_id)
            end
        end
    end
end
