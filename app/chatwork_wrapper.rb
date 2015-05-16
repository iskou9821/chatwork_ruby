require 'httpclient'
require 'yaml'
require 'json'


def onData(json)
  begin
    return JSON.parse(json, :quirks_mode => true)
  rescue JSON::ParserError => pe
    puts "  JSON変エラー:#{json}"
    puts "  文字列をJSONとしてparse出来ませんでした:#{pe}"
    return nil
  end
end

def onError(e)
  puts "ERROR!!!!#{e}"
end

module ChatworkWrapper
  BASE_URL='https://api.chatwork.com/v1';

  #Chatwork APIの認証トークンに関する設定
  class Token
    @token

    def initialize(filename)
      if (!File.exist? filename)
        put 'ファイル #{file_name} が見つかりません'
      end
      conf = YAML.load_file filename
      @token = conf['chatwork']['token']
    end

    def getToken
      return @token
    end

    def httpHeader
      return { 'X-ChatWorkToken' => @token }
    end
  end

  #GETを実行
  def get(endpoint, param, token, &callback)
    client = HTTPClient.new
    begin
      url = "#{BASE_URL}/#{endpoint}";
      client.get_content url, param, token.httpHeader do |json|
        data = onData json
        callback.call(data) if (json != nil)
      end
    rescue => e
      puts "ERROR!!!!#{e}"
    end
  end

  def post(endpoint, params, token, &callback)
    client = HTTPClient.new
    begin
      url = "#{BASE_URL}/#{endpoint}";
      client.post_content url, params, token.httpHeader do |json|
        data = onData json
        callback.call(data) if (json != nil)
      end
    rescue => e
      onError e
    end
  end

  module_function :post
  module_function :get

  class ChatworkUser
    def self.get_info(token)
      me = nil
      ChatworkWrapper.get('me','',token) {|data|
        me = data
      }
      return me
    end

    def self.get_status(token)
      sts = nil
      ChatworkWrapper.get('my/status','',token) {|data|
        sts = data
      }
      return sts
    end

    def self.get_tasks(token,assigned_by_account_id=nil,status=nil)
      tasks = nil

      params = ''
      if (assigned_by_account_id != nil && status != nil)
        params = "assigned_by_account_id=#{assigned_by_account_id}&status=#{status}"
      elsif (assigned_by_account_id != nil)
        params = "assigned_by_account_id=#{assigned_by_account_id}"
      elsif (status != nil)
        params = "status=#{status}"
      end

      ChatworkWrapper.get('my/tasks',params,token) {|data|
        tasks = data
      }
      return tasks
    end
  end


  class ChatworkRoom
    def self.get_rooms(token)
      rooms = {};
      ChatworkWrapper.get('rooms','',token) {|items|
        items.each {|item|
          name = item['name']
          rooms[name] = item
        }
      }
      return rooms
    end

    def self.post_message(token, room_name, message)
      rooms = get_rooms(token)
      room = rooms[room_name]
      return nil if (room == nil)
      return post_message_with_id token, room['room_id'], message
    end

    def self.post_message_with_id(token, room_id, message)
      res = nil
      escaped = URI.escape message
      param =  "body=#{escaped}"
      ChatworkWrapper.post("rooms/#{room_id}/messages",param,token) {|data|
        res = data;
      }
      return res;
    end
  end
end