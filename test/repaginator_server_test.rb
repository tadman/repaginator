require 'test_helper'

class RepaginatorServerTest < Test::Unit::TestCase
  def test_create_server
    EventMachine.run do
      EventMachine::start_server('localhost', Repaginator::Server.port, Repaginator::Server, 'test')

      client = EventMachine::Protocols::Memcache.connect('localhost', Repaginator::Server.port)

      client.get('test') do |result|
        assert_equal 'test', result
      end
      
      EventMachine::stop_event_loop
    end
  end
end
