require '../chatwork_wrapper'

token = ChatworkWrapper::Token.new('/var/conf/chatwork.yaml')

ChatworkWrapper.get('my/status','',token) {|data|
    puts data
}