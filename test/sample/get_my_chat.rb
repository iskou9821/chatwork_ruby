require '../../app/chatwork_wrapper'

def getMyChat(token)
  rooms = nil
  ChatworkWrapper.get('rooms','',token) {|data|
    puts 'ルームリストを取得'
    p data
    rooms = data
  }
  return rooms.find { |room| room['name'] == 'マイチャット' }
end
