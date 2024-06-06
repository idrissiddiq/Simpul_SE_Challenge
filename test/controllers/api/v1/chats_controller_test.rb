require "test_helper"

module Api
  module V1
    class ChatsControllerTest < ActionDispatch::IntegrationTest  
      setup do
        # @user = 1
        @chat1 = Chat.create!(sender_id: 1, sender: "Mary Hilda", message: "Just Fill me in for his updates yea?")
        @chat2 = Chat.create!(sender_id: 1, sender: "You", message: "No worries. It will be completed ASAP. Ive asked him yesterday.")
        @chat3 = Chat.create!(sender_id: 1, sender: "Mary Hilda", message: "Hello Obaidullah, I will be your case advisor for case #029290. I have assigned some homework for you to fill. Please keep up with the due dates. Should you have any questions, you can message me anytime. Thanks.")
        @chat4 = Chat.create!(sender_id: 1, sender: "You", message: "Please contact Mary for questions regarding the case bcs she will be managing your forms from now on! Thanks Mary.")
        @chat5 = Chat.create!(sender_id: 1, sender: "Mary Hilda", message: "Please contact Mary for questions regarding the case bcs she will be managing your forms from now on! Thanks Mary.")
      end

      test "should get chats by sender" do
        get api_v1_chats_sender_url(sender_id: 1), as: :json
        assert_response :success

        json_response = JSON.parse(response.body)
        assert_equal 5, json_response.length
        
        assert_equal @chat1.id, json_response[0]["id"]
        assert_equal @chat1.sender, json_response[0]["sender"]
        assert_equal @chat1.message, json_response[0]["message"]
        
        assert_equal @chat2.id, json_response[1]["id"]
        assert_equal @chat2.sender, json_response[1]["sender"]
        assert_equal @chat2.message, json_response[1]["message"]

        assert_equal @chat3.id, json_response[2]["id"]
        assert_equal @chat3.sender, json_response[2]["sender"]
        assert_equal @chat3.message, json_response[2]["message"]

        assert_equal @chat4.id, json_response[3]["id"]
        assert_equal @chat4.sender, json_response[3]["sender"]
        assert_equal @chat4.message, json_response[3]["message"]

        assert_equal @chat5.id, json_response[4]["id"]
        assert_equal @chat5.sender, json_response[4]["sender"]
        assert_equal @chat5.message, json_response[4]["message"]
      end

      test "should create chat" do
        assert_difference('Chat.count', 1) do
          post api_v1_chats_url, params: { chat: { sender_id: @user.id, sender: "Test Sender", message: "New message" } }, as: :json
        end

        assert_response :success
        json_response = JSON.parse(response.body)
        assert_equal "New message", json_response["message"]
        assert_equal @user.id, json_response["sender_id"]
        assert_equal "Test Sender", json_response["sender"]
      end

      test "should not create chat with invalid params" do
        post api_v1_chats_url, params: { chat: { message: "" } }, as: :json
        assert_response :unprocessable_entity

        json_response = JSON.parse(response.body)
        assert_not_empty json_response
      end
    end
  end
end
