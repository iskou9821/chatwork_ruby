require '../../app/chatwork_wrapper'

token = ChatworkWrapper::Token.new('/var/conf/chatwork.yaml')

ChatworkWrapper.get('my/status','',token) {|data|
  puts 'ステータス'
  p data
}

ChatworkWrapper.get('my/tasks','',token) {|data|
  puts 'タスク'
  p data
}