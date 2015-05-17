require '../app/chatwork_wrapper'

token = ChatworkWrapper::Token.new('/var/conf/chatwork.yaml')

#ユーザーのステータス(未読・未読To・未完了タスク)を取得
info = ChatworkWrapper::ChatworkUser.get_status token

puts "unread_room_num:#{info['unread_room_num']}"
puts "mention_room_num:#{info['mention_room_num']}"
puts "mytask_room_num:#{info['mytask_room_num']}"
puts "unread_num:#{info['unread_num']}"
puts "mention_num:#{info['mention_num']}"
puts "mytask_num:#{info['mytask_num']}"