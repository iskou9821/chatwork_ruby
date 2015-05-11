require '../app/chatwork_wrapper'

token = ChatworkWrapper::Token.new('/var/conf/chatwork.yaml')

# チャットルームに投稿
ChatworkWrapper::ChatworkRoom.post_message token, 'マイチャット', <<"text"
  テストです。
  テストですす。
  テストですです。
text
