require '../app/chatwork_wrapper'

token = ChatworkWrapper::Token.new('/var/conf/chatwork.yaml')

#自分のコンタクトリストを取得
tasks = ChatworkWrapper::ChatworkUser.get_contacts token
tasks.each_value {|c|
  puts '*******************************'
  puts "account_id:#{c['account_id']}"
  puts "room_id:#{c['room_id']}"
  puts "name:#{c['name']}"
  puts "chatwork_id:#{c['chatwork_id']}"
  puts "organization_id:#{c['organization_id']}"
  puts "organization_name:#{c['organization_name']}"
  puts "department:#{c['department']}"
  puts "avatar_image_url:#{c['avatar_image_url']}"
}