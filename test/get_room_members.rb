require '../app/chatwork_wrapper'

token = ChatworkWrapper::Token.new('/var/conf/chatwork.yaml')

#チャットルームの情報を取得
rooms = ChatworkWrapper::ChatworkRoom.get_room_members token, 'マイチャット'
rooms.each_value {|member|
  puts '*******************************'
  puts "account_id:#{member['account_id ']}"
  puts "role:#{member['role']}"
  puts "name:#{member['name']}"
  puts "chatwork_id:#{member['chatwork_id']}"
  puts "organization_id:#{member['organization_id']}"
  puts "organization_name:#{member['organization_name']}"
  puts "department:#{member['department']}"
  puts "avatar_image_url:#{member['avatar_image_url']}"
}
