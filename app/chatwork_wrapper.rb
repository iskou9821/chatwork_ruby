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
end
