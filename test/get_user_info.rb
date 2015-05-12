require '../app/chatwork_wrapper'

token = ChatworkWrapper::Token.new('/var/conf/chatwork.yaml')

#ユーザーの情報を取得
user = ChatworkWrapper::CharworkUser.get_user_info token

puts "account_id=#{puts user['account_id']}"
puts "room_id=#{user['room_id']}"
puts "name=#{user['name']}"
puts "chatwork_id=#{user['chatwork_id']}"
puts "organization_id=#{user['organization_id']}"
puts "organization_name=#{user['organization_name']}"
puts "department=#{user['department']}"
puts "title=#{user['title']}"
puts "url=#{user['url']}"
puts "introduction=#{user['introduction']}"
puts "mail=#{user['mail']}"
puts "tel_organization=#{user['tel_organization']}"
puts "tel_extension=#{user['tel_extension']}"
puts "tel_mobile=#{user['tel_mobile']}"
puts "skype=#{user['skype']}"
puts "facebook=#{user['facebook']}"
puts "twitter=#{user['twitter']}"
puts "avatar_image_url=#{user['avatar_image_url']}"
