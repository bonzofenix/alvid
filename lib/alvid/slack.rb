require 'yaml'
require 'json'
require 'faye/websocket'

class Alvid::Slack
  def initialize(url)
    @url = url
  end

  def send_message(msg)
    ws.send(msg)
  end

  def start
    EM.run do
      ws.on :open do |event|
        puts "============ open ssocker robot"
      end

      ws.on :message do |event|
        puts "============ reciving message robot"
        args = JSON.parse(event.data).fetch('text').split(' ')
        cmd = args.shift.capitalize!
        action = args.shift
        opts = args.join(' ')

        Kernel.const_get("Alvid::#{cmd}").new.send(action, opts)
      end

      ws.on :close do |event|
        puts "============ stoping robot"
        EM.stop
      end
    end
  end

  private
  def ws
    return @ws unless @ws.nil?
        puts "============ creating socket robot"
    @ws ||= Faye::WebSocket::Client.new(@url)
  end
end
