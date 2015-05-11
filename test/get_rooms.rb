require '../app/chatwork_wrapper'

token = ChatworkWrapper::Token.new('/var/conf/chatwork.yaml')

#チャットルームの情報を取得
rooms = ChatworkWrapper::ChatworkRoom.get_rooms token
rooms.each_value {|room|
  puts '*******************************'
  puts "  room_id= #{room['room_id']}"
  puts "  name = #{room['name']}"
  puts "  type = #{room['type']}"
  puts "  role = #{room['role']}"
  puts "  sticky = #{room['sticky']}"
  puts "  unread_num = #{room['unread_num']}"
  puts "  mention_num = #{room['mention_num']}"
  puts "  mytask_num = #{room['mytask_num']}"
  puts "  message_num = #{room['message_num']}"
  puts "  file_num = #{room['file_num']}"
  puts "  task_num = #{room['task_num']}"
  puts "  icon_path = #{room['icon_path']}"
  puts "  last_update_time = #{room['last_update_time']}"
  puts ''
}
