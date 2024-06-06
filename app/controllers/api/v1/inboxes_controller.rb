module Api
    module V1
        class InboxesController < ApplicationController
            def index
                render json: Inbox.order(:name)
            end
            def create
                @inbox = Inbox.new(inbox_params)
                if @inbox.save
                    render json: @inbox
                else
                    render json: @inbox.errors, status: unprocessable_entity
                end
            end

            private

            def inbox_params
                params.require(:inbox).permit(:name, :status)
            end
        end
    end
end
