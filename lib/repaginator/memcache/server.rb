# Stub implementation of a basic Memcache server
#
# Protocol Documentation:
#   http://code.sixapart.com/svn/memcached/trunk/server/doc/protocol.txt

module Repaginator
  module Memcache
    class Server < EventMachine::Protocols::LineAndTextProtocol
      include EventMachine::Protocols::LineText2
      # == Class Methods ====================================================
      
      # == Instance Methods =================================================
      
      # -- Server Instance Methods ------------------------------------------
      
      def receive_line(line)
        arguments = line.split(/\s+/)
        command = arguments.shift
        
        if (!command or command.empty?)
          reply_with_error
        else
          command_sym = :"#{command.downcase}_command"
          if (respond_to?(command_sym))
            send(command_sym, *arguments)
          else
            reply_with_error("Unsupported command #{command.upcase}", :client)
          end
        end
      rescue ArgumentError
        reply_with_error("Incorrect arguments to #{command.upcase}")
      end
      
      def receive_binary_data(data)
        # ...
      end
      
      def reply_with(content)
        send_data(content)
        send_data("\r\n")
      end
      
      def reply_with_value(key, flags)
        send_data(content + "END\r\n")
      end
      
      def reply_with_error(message = nil, type = :server)
        if (message)
          case (type)
          when :client
            send_data("CLIENT_ERROR #{message}\r\n")
          else
            send_data("SERVER_ERROR #{message}\r\n")
          end
        else
          send_data("ERROR\r\n")
        end
      end
      
      # -- Command Implementation Stubs -------------------------------------
      
      def quit_command
        close_connection_after_writing
      end
    end
  end
end