require '../../app/chatwork_wrapper'

token = ChatworkWrapper::Token.new('/var/conf/chatwork.yaml')

ChatworkWrapper.get('contacts', '', token){ |data|
  puts 'コンタクトリスト'
  p data
}