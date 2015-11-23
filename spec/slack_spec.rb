require 'spec_helper'
require 'yaml'
require 'rack'

Faye::WebSocket.load_adapter('thin')
Thin::Logging.silent = true

class EchoServer
  def initialize
      @server = nil
  end

  def call(env)
    socket = Faye::WebSocket.new(env)
    socket.onmessage = lambda do |event|
      socket.send(event.data)
    end
    socket.rack_response
  end

  def log(*args)
  end

  def listen(port)
    puts "============ starting thin server"
    Rack::Handler.get('thin').run(self, :Port => port) do |s|
      @server = s
    end
  end

  def stop
    puts "============ stopping thin server"
    @server.stop
  end
end


def eventmachine(timeout = 1)
  Timeout::timeout(timeout) do
    EM.run do
      yield
    end
  end
rescue Timeout::Error
  puts 'Eventmachine was not stopped before the timeout expired'
end

describe Alvid::Slack do
  let(:port){ 4180 }
  let(:url) { "ws://localhost:#{port}/"  }
  let(:slack){ described_class.new(url) }
  let(:ws){ Faye::WebSocket::Client.new(url) }
  let(:echo_server) { EchoServer.new }

  describe "when listening on received messages" do
    it 'calls retro.add on retro add' do
      expect_any_instance_of(Alvid::Retro).to receive(:add).with('banana')

      eventmachine do
        EM.add_timer(0.1){ echo_server.listen(port) }
        EM.add_timer(0.2){ slack.start }
        EM.add_timer(0.3) do
          slack.send_message(
            '''
          {
          "type": "message",
          "ts": "1358878749.000002",
          "user": "U023BECGF",
          "text": "retro add banana"
          }
            ''')
        end
        EM.add_timer(0.4){ echo_server.stop }
      end
    end
  end
end
