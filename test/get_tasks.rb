require '../app/chatwork_wrapper'

token = ChatworkWrapper::Token.new('/var/conf/chatwork.yaml')

#自分のタスクを取得
tasks = ChatworkWrapper::ChatworkUser.get_tasks token
tasks.each {|task|
  puts '*******************************'
  puts "task_id:#{task['task_id']}"
  puts "message_id:#{task['message_id']}"
  puts "limit_time:#{task['limit_time']}"
  puts "status:#{task['status']}"
  puts "room.room_id:#{task['room']['room_id']}"
  puts "room.name:#{task['room']['name']}"
  puts "room.icon_path:#{task['room']['icon_path']}"
  puts "assigned_by_account.account_id:#{task['assigned_by_account']['account_id']}"
  puts "assigned_by_account.name:#{task['assigned_by_account']['name']}"
  puts "assigned_by_account.avatar_image_url:#{task['assigned_by_account']['avatar_image_url']}"
}