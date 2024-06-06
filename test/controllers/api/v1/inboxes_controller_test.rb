require 'test_helper'

module Api
  module V1
    class InboxesControllerTest < ActionDispatch::IntegrationTest
      setup do
        @inbox1 = Inbox.create!(name: 'Alpha', status: 'open')
        @inbox2 = Inbox.create!(name: 'Beta', status: 'closed')
        @inbox3 = Inbox.create!(name: 'Gamma', status: 'open')
      end

      test "should get index" do
        get api_v1_inboxes_url, as: :json
        assert_response :success

        json_response = JSON.parse(response.body)
        assert_equal 3, json_response.length
        assert_equal 'Alpha', json_response.first['name']
        assert_equal 'Gamma', json_response.last['name']
      end

      test "should create inbox" do
        assert_difference('Inbox.count', 1) do
          post api_v1_inboxes_url, params: { inbox: { name: 'Delta', status: 'open' } }, as: :json
        end

        assert_response :success
        json_response = JSON.parse(response.body)
        assert_equal 'Delta', json_response['name']
        assert_equal 'open', json_response['status']
      end

      test "should not create inbox with invalid params" do
        post api_v1_inboxes_url, params: { inbox: { name: '' } }, as: :json
        assert_response :unprocessable_entity

        json_response = JSON.parse(response.body)
        assert_not_empty json_response
      end
    end
  end
end
