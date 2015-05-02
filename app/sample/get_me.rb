require 'httpclient'
require 'json'
require 'yaml'

conf = YAML.load_file '/var/conf/chatwork.yaml'
token = conf['chatwork']['token']

BASE_URL='https://api.chatwork.com/v1';

client = HTTPClient.new

begin
  client.get_content "#{BASE_URL}/me", '', {'X-ChatWorkToken' => token} do |json|
    data = JSON.parse(json)
    puts data['account_id']
  end
rescue HTTPClient::BadResponseError, HTTPClient::TimeoutError => e
  puts 'ERROR!!!!'
  puts e
end
