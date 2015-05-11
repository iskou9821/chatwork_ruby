require '../../app/chatwork_wrapper'
require './get_my_chat'

token = ChatworkWrapper::Token.new('/var/conf/chatwork.yaml')

mychat = getMyChat token
roomId = mychat['room_id']

p mychat

param =  'body=テスト投稿です'


ChatworkWrapper.post("rooms/#{roomId}/messages",param,token) {|data|
  puts 'マイチャットにメッセージ投稿'
  p data
}
