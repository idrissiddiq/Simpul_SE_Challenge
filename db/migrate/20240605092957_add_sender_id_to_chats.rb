class AddSenderIdToChats < ActiveRecord::Migration[7.0]
  def change
    add_column :chats, :sender_id, :integer
  end
end
