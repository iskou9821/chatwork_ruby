require 'httpclient'
require 'yaml'
require 'json'


module ChatworkWrapper
  BASE_URL='https://api.chatwork.com/v1';

  #Chatworの認証を通すためのトークンを取得
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

  def get(endpoint, param, token, &callback)
    client = HTTPClient.new
    begin
      client.get_content "#{BASE_URL}/#{endpoint}", param, token.httpHeader do |json|
        data = JSON.parse(json)
        callback.call data
      end
    rescue HTTPClient::BadResponseError, HTTPClient::TimeoutError => e
      puts 'ERROR!!!!'
      puts e
    end
  end

  module_function :get
end
