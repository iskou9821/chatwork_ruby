require '../chatwork_wrapper'

token = ChatworkWrapper::Token.new('/var/conf/chatwork.yaml')

rooms = nil
ChatworkWrapper.get('rooms','',token) {|data|
  puts 'ルームリストを取得'
  p data
  rooms = data
}

mychat = rooms.find { |room| room['name'] == 'マイチャット' }

puts 'マイチャット：'
p mychat

roomId = mychat['room_id']
puts "マイチャットのroomId=#{roomId}"

ChatworkWrapper.get("rooms/#{roomId}",'',token) {|data|
  puts 'マイチャットの情報を取得'
  p data
}

ChatworkWrapper.get("rooms/#{roomId}/messages",'force=1',token) {|data|
  puts 'マイチャットのメッセージを取得'
  p data
}

