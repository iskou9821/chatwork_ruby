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

=begin
  なんとなく動きが不安定な場合があるような感じがする。
  取得すべきデータが無いとエラーになったりとか、JSONのパースエラーが発生したりとか。
  うまくコールバックが実行されないことがあるのは、一体どういう原因からなんだろうか？？？
  （しかも、exit code=0で終了しているという・・・）
  おそらくリクエスト送信時にrescueを付けていることとか、
　JSON文字列が途中までしか来てないことがあるっぽいとか、
　そういうのも関係あるんだろうなと思う。
=end

ChatworkWrapper.get("rooms/#{roomId}",'',token) {|data|
  puts 'マイチャットの情報を取得'
  p data
}

ChatworkWrapper.get("rooms/#{roomId}/messages",'force=1',token) {|data|
  puts 'マイチャットのメッセージを取得'
  p data
}

ChatworkWrapper.get("rooms/#{roomId}/tasks",'status=open',token) { |data|
  puts 'マイチャットのタスクを取得'
  p data
}
